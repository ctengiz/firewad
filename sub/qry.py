""" 
Sql Query, Browse Data and other DML operations
"""

import json
import base64
import datetime
import decimal
import re

import fdb
from bottle import request, redirect, HTTPError, template, response
from sub.db import connect_db

from common import baseApp, appconf, render, formval_to_utf8


def process_val(cval):

    return_val = cval

    type_ = type(cval)

    if cval is None:
        return_val = ''
    else:
        if type_ in base64.bytes_types:
            return_val = base64.b64encode(cval).decode("utf-8")
        elif type_ is datetime.date:
            return_val = cval.strftime('%d.%m.%Y')
        elif type_ is datetime.datetime:
            return_val = cval.strftime('%d.%m.%Y %H:%M')
        elif type_ is decimal.Decimal:
            return_val = str(cval)

    return return_val


def parse_params(sql, **prms):
    """
    Converts named parameters (ie :param) of a sql statement to qmark represantation and gives correct
    order of parameters for substition of qmark parameters

    :param sql: source sql statement contains named parameter
    :param prms: dict of paramaters
    :return: qmark style sql and parameters list
    """

    #regex for finding named params (ie :param)
    #source : http://www.rexegg.com/regex-best-trick.html#notarzan
    p = re.compile('''":[_a-zA-Z0-9]+"|':[_a-zA-Z0-9]+'|(:[_a-zA-Z0-9]+)''')

    #change :param expression to qmark
    result_sql = re.sub(p, '?', sql)

    #construct parameters list
    result_params = []
    for pr in re.findall(p, sql):
        pr = pr[1:].lower()
        if pr in prms.keys():
            if prms[pr] == '':
                _prm_val = None
            else:
                _prm_val = prms[pr]
            result_params.append(_prm_val)
        else:
            result_params.append(None)

    return result_sql, tuple(result_params)


@baseApp.route('/tools/query/<db>', method=['GET', 'POST'])
def query(db):
    if db not in appconf.con:
        connect_db(db)

    if request.method == 'GET':
        _col = None
        _prms_str = ''
        _refresh_obj = ''
        if 'table' in request.GET:
            _table_name = request.GET.table
            _col = appconf.con[db].schema.get_table(_table_name).columns
        elif 'view' in request.GET:
            _table_name = request.GET.view
            _col = appconf.con[db].schema.get_view(_table_name).columns
        elif 'procedure' in request.GET:
            _table_name = request.GET.procedure
            _col = appconf.con[db].schema.get_procedure(_table_name).output_params
            _prm = appconf.con[db].schema.get_procedure(_table_name).input_params
            _prms_str = ', '.join([':' + t.name for t in _prm])
            _prms_str = '(' + _prms_str + ')'

        _select_sql_str = ""
        if _col:
            _select_sql_str += 'select\n'
            _select_sql_str += ',\n'.join(['  ' + t.name for t in _col])
            _select_sql_str += '\nfrom ' + _table_name + _prms_str
        else:
            if 'procedure' in request.GET:
                _select_sql_str += 'execute procedure'
                _select_sql_str += '\n  ' + _table_name + _prms_str

        return template('sql_script', db=db, sql=_select_sql_str, refresh_object = _refresh_obj, extyp='query')
    else:
        sql = request.POST.sql
        exec_typ = request.POST.exec_typ

        try:
            crs = appconf.con[db].cursor()

            _params = {}
            for _pp in request.POST:
                if _pp[0:7] == 'params[':
                    _params[_pp[7:-1]] = formval_to_utf8(request.POST[_pp])

            nsql, nprms = parse_params(sql, **_params)
            pst = crs.prep(nsql)

            if exec_typ == 'plan':
                return json.dumps({'plan':pst.plan})
            else:
                crs.execute(pst, nprms)
        except Exception as e:
            response.status = 500
            return e.args[0].replace('\n', '<br/>')

        columns = []
        for _fld in crs.description:
            columns.append(
                {'field': _fld[0],
                 'title': _fld[0].replace('_', ' ').title(),
                 'sortable': True,
                 'filterControl': 'input'
                 }
            )
            """
            _fld_def['type_code'] = _fld[1]
            _fld_def['display_size'] = _fld[2]
            _fld_def['internal_size'] = _fld[3]
            _fld_def['precision'] = _fld[4]
            _fld_def['scale'] = _fld[5]
            _fld_def['null_ok'] = _fld[6]
            fields.append(_fld_def)
            """

        data = []
        for row in crs.fetchallmap():
            jrw = {}
            for k in row:
                #print(k, row[k], type(row[k]).__name__, type(row[k]))
                json.dumps({k: process_val(row[k])})
                jrw[k] = process_val(row[k])
            data.append(jrw)

        return json.dumps({'plan': pst.plan,
                           'tdata': {'columns': columns,
                                     'data': data}})

@baseApp.route('/tools/script/<db>', method=['GET', 'POST'])
def script(db):
    if db not in appconf.con:
        connect_db(db)

    if request.method == 'GET':
        prms = request.GET
        _sql = ''
        refresh_obj = ''

        if 'sql' in prms:
            _sql = prms.sql
            if 'encoded' in prms:
                _sql = base64.urlsafe_b64decode(_sql.encode("ascii")[2:-1]).decode("utf-8")

        if 'ddl' in prms:
            _ddl = prms.ddl
            _typ = prms.typ
            _name = prms.name
            
            if _ddl == 'drop':
                refresh_obj = _typ + 's'

                if _typ == 'function':
                    _sql = _obj = appconf.con[db].schema.get_function(_name).get_sql_for('drop') + ';'
                else:
                    _sql = 'drop %s %s;' %(_typ, _name)

            elif _ddl == 'edit':
                if _typ == 'table':
                    _obj = appconf.con[db].schema.get_table(_name)
                    _sql = _obj.get_sql_for('recreate') + ';'

                    #todo: not sure if I should add these to the script ?
                    """
                    for _cns in _obj.constraints:
                        if not _cns.isnotnull():
                            _sql += '\n' + _cns.get_sql_for('create') + ';'

                    for _ndx in _obj.indices:
                        _sql += '\n' + _ndx.get_sql_for('create') + ';'
                    """

                elif _typ == 'view':
                    _sql = appconf.con[db].schema.get_view(_name).get_sql_for('recreate')
                elif _typ == 'procedure':
                    _sql = appconf.con[db].schema.get_procedure(_name).get_sql_for('create_or_alter')
                elif _typ == 'trigger':
                    _sql = appconf.con[db].schema.get_trigger(_name).get_sql_for('recreate')
                elif _typ == 'exception':
                    _sql = appconf.con[db].schema.get_exception(_name).get_sql_for('recreate')
                elif _typ == 'sequence':
                    _sql = appconf.con[db].schema.get_sequence(_name).get_sql_for('create')
                elif _typ == 'index':
                    _sql = appconf.con[db].schema.get_index(_name).get_sql_for('create')
                elif _typ == 'domain':
                    _obj = appconf.con[db].schema.get_domain(_name)
                    _sql = _obj.get_sql_for('alter', default=_obj.default) + ';\n'
                    _sql += _obj.get_sql_for('alter', check=_obj.validation) + ';\n'
                    _sql += _obj.get_sql_for('alter', datatype=_obj.datatype) + ';\n'
                    _sql += _obj.get_sql_for('alter', name=_obj.name) + ';\n'

            elif _ddl == 'create':
                refresh_obj = _typ + 's'

                if _typ == 'view':
                    _sql = template('./sqls/view')
                if _typ == 'trigger':
                    _sql = template('./sqls/trigger')
                elif _typ == 'sequence':
                    _sql = 'create sequence NEW_SEQUENCE;'
                elif _typ == 'exception':
                    _sql = "create exception NEW_EXCEPTION '<exception_message>';"
                elif _typ == 'role':
                    _sql = "create role NEW_ROLE"
                    
            elif _ddl == 'trigger_disable' or _ddl == 'trigger_enable':
                refresh_obj = 'triggers'

                if _typ == 'table':
                    _objs = appconf.con[db].schema.get_table(_name).triggers
                elif _typ == 'trigger':
                    _objs = [appconf.con[db].schema.get_trigger(_name)]
                else:
                    _objs = appconf.con[db].triggers

                _opr = 'inactive' if _ddl == 'trigger_disable' else 'active'
                for k in _objs:
                    _sql += 'alter trigger %s %s;\n' % (k.name, _opr)

            elif _ddl == 'index_disable' or _ddl == 'index_enable':
                refresh_obj = 'indices'

                if _typ == 'table':
                    _objs = appconf.con[db].schema.get_table(_name).indices
                else:
                    _objs = appconf.con[db].indices

                _opr = 'inactive' if _ddl == 'index_disable' else 'active'
                for k in _objs:
                    if not k.isenforcer():
                        _sql += 'alter index %s %s;\n' % (k.name, _opr)

            elif _ddl == 'index_recompute':
                refresh_obj = 'indices'

                if _typ == 'table':
                    _objs = appconf.con[db].schema.get_table(_name).indices
                else:
                    _objs = appconf.con[db].indices

                for k in _objs:
                    _sql += 'SET statistics INDEX %s;\n' % k.name

        return template('sql_script', db=db, sql=_sql, refresh_object=refresh_obj, extyp='script')
    else:
        prms = request.POST
        script = prms.sql
        auto_commit = int(prms.auto_commit)
        trn = None
        trn_id = None

        if 'action' in prms:
            try:
                trn_id = int(prms.trn_id)
                trn = appconf.trn[trn_id]
            except:
                response.status = 500
                return 'Associated transaction ID is invalid !'

            try:
                if prms.action == 'commit':
                    trn.commit()
                    trn.close()
                    appconf.trn.pop(trn_id)
                    if prms.refresh:
                        appconf.con[db].schema.reload(prms.refresh)
                    return json.dumps({'errors': [], 'result': 'Transaction committed', 'trn_id': None})
                else:
                    trn.rollback()
                    trn.close()
                    appconf.trn.pop(trn_id)
                    return json.dumps({'errors': [], 'result': 'Transaction rolled back', 'trn_id': None})
            except Exception as e:
                response.status = 500
                return e.args[0].replace('\n', '<br/>')

        trn = appconf.con[db].trans()
        if not auto_commit:
            trn.begin()
            trn_id = trn.trans_info(fdb.isc_info_tra_id)
            appconf.trn[trn_id] = trn

        error_log = []
        try:

            #very very dirty hack for sql statement parsing
            #for identfying procedure and trigger blocks !!
            #a decent sql parser would be better

            #match procedure / trigger / execute blocks
            p = re.compile(r"(execute(\s)block|create(\s)+(procedure|trigger))(?s).*?(.*?)end(\s*);", re.IGNORECASE)
            block_num = 0
            blocks = []
            iterator = p.finditer(script)
            for match in iterator:
                blocks.append(match.group())
                block_text = ';__block:%d;' % block_num
                script = script.replace(match.group(), block_text, 1)
                block_num += 1

            #replace block comments
            p = re.compile(r"/\*(?s).*?\*/")
            script = p.sub("", script)

            sqls = []
            lines = script.split(';')
            for ndx, ln in enumerate(lines):
                ln = ln.strip()
                if ln[0:7] == '__block':
                    block_num = int(ln.split(':')[1])
                    sql = blocks[int(ln.split(':')[1])]
                elif ln[0:2] == '--':
                    _new_ln = '\n'.join(ln.splitlines()[1:]).strip()
                    if _new_ln:
                        lines.insert(ndx + 1, _new_ln)
                    sql = None
                else:
                    sql = ln

                if sql:
                    sqls.append(sql)

            for sql in sqls:
                trn.execute_immediate(sql)

            if auto_commit:
                trn.commit()
                trn.close()
                if prms.refresh:
                    appconf.con[db].schema.reload(prms.refresh)
        except Exception as e:
            if auto_commit:
                trn.rollback()
                trn.close()
            _error = e.args[0].replace('\n', '<br/>') + '<br/>' + sql
            error_log.append(_error)

        if error_log != []:
            result = 'Script executed with errors'
        else:
            result = 'Script executed successfully'

        return json.dumps({'errors': error_log, 'result': result, 'trn_id': trn_id})
