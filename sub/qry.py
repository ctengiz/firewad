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

    _template = 'query-bootstrap-table'
    _template = 'query-raw'

    if request.method == 'GET':
        _col = None
        _prms_str = ''
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

        return template(_template, db=db, sql_select=_select_sql_str)
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

        return json.dumps({'plan':pst.plan,
                           'tdata':{'columns': columns,
                                    'data': data}})

