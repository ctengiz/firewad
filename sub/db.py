""" 
Database objects and DDL operations
"""

import fdb
from bottle import request, redirect, HTTPError

from common import baseApp, appconf, render, formval_to_utf8, highlight_sql


def register_ddl(db):
    appconf.ddl[db] = {}
    appconf.ddl[db]['tables'] = sorted([t.name for t in appconf.con[db].tables])
    appconf.ddl[db]['views'] = sorted([t.name for t in appconf.con[db].views])
    appconf.ddl[db]['triggers'] = sorted([t.name for t in appconf.con[db].triggers])
    appconf.ddl[db]['views'] = sorted([t.name for t in appconf.con[db].views])
    appconf.ddl[db]['domains'] = sorted([t.name for t in appconf.con[db].domains])
    appconf.ddl[db]['sequences'] = sorted([t.name for t in appconf.con[db].sequences])
    appconf.ddl[db]['procedures'] = sorted([t.name for t in appconf.con[db].procedures])
    appconf.ddl[db]['indices'] = sorted([t.name for t in appconf.con[db].indices])
    appconf.ddl[db]['functions'] = sorted([t.name for t in appconf.con[db].functions])
    appconf.ddl[db]['exceptions'] = sorted([t.name for t in appconf.con[db].exceptions])
    appconf.ddl[db]['constraints'] = sorted([t.name for t in appconf.con[db].constraints])
    appconf.ddl[db]['roles'] = sorted([t.name for t in appconf.con[db].roles])


def connect_db(db):
    appconf.con[db] = fdb.connect(
        host=appconf.db_config[db]['db_server'],
        database=appconf.db_config[db]['db_path'],
        user=appconf.db_config[db]['db_user'],
        password=appconf.db_config[db]['db_pass'],
        charset=appconf.db_config[db]['charset'],
        role=appconf.db_config[db]['db_role'],
        sql_dialect=int(appconf.db_config[db]['dialect']),
        connection_class=fdb.ConnectionWithSchema
    )

    register_ddl(db)

@baseApp.route('/db/register', method=['GET', 'POST'])
def db_register():
    if request.method == 'GET':

        _reg = {
            'db_server': '',
            'db_path': '',
            'db_user': '',
            'db_pass': '',
            'db_role': '',
            'dialect': '',
            'charset': ''
        }
        if 'db' in request.GET:
            _db = formval_to_utf8(request.GET['db'])
            for k in _reg:
                _reg[k] = appconf.db_config[_db][k]
            _reg['db_alias'] = _db
        else:
            _reg['db_alias'] = ''

        return render(tpl='db_register', reg=_reg)
    else:
        prms = request.POST

        if prms.old_alias:
            appconf.db_config.pop(prms.old_alias, None)

        appconf.db_config[prms.db_alias] = {
            'db_server': prms.db_server,
            'db_path': prms.db_path,
            'db_user': prms.db_user,
            'db_pass': prms.db_pass,
            'db_role': prms.db_role,
            'dialect': prms.dialect,
            'charset': prms.charset
        }
        with open('%s/dbconfig.ini' % appconf.basepath, 'w+', encoding='utf-8') as f:
            appconf.db_config.write(f)

        redirect('/db/list')


@baseApp.route('/db/unregister/<db>')
def db_unegister(db):
    if db in appconf.con:
        appconf.con[db].disconnect()

    appconf.con.pop(db, None)
    appconf.ddl.pop(db, None)
    appconf.db_config.pop(db, None)

    with open('%s/dbconfig.ini' % appconf.basepath, 'w+', encoding='utf-8') as f:
        appconf.db_config.write(f)

    redirect('/db/list')

@baseApp.route('/db/refresh_cache_metadata/<db>', method=['GET', 'POST'])
def refresh_cache_metadata(db):
    if db not in appconf.con:
        connect_db(db)

    register_ddl(db)
    redirect('/db/%s' %(db))


@baseApp.route('/db/metadata/<db>', method=['GET', 'POST'])
def db_metadata(db):
    def fancy_header(title):
        return '\n\n/' + ('*' * 78) + \
               '/\n' + '/*' + title + (' ' * (76 - len(title))) + \
               '*/\n' + '/' + ('*' * 78) + '/\n'

    if db not in appconf.con:
        connect_db(db)

    if request.method == 'GET':
        return render('db_metadata', db=db)
    else:
        prms = request.POST

        rslt = ''
        if 'function' in prms:
            rslt += fancy_header('USER DEFINED FUNCTIONS')
            for obj in sorted(appconf.con[db].functions, key=lambda k: str(k.name)):
                rslt += obj.get_sql_for('declare') + ';\n\n'

        if 'domain' in prms:
            rslt += fancy_header('DOMAINS')
            for obj in sorted(appconf.con[db].domains, key=lambda k: str(k.name)):
                rslt += obj.get_sql_for('create') + ';\n'

        if 'sequence' in prms:
            rslt += fancy_header('SEQUENCES')
            for obj in sorted(appconf.con[db].sequences, key=lambda k: str(k.name)):
                rslt += obj.get_sql_for('create') + ';\n'

        if 'exception' in prms:
            rslt += fancy_header('EXCEPTIONS')
            for obj in sorted(appconf.con[db].exceptions, key=lambda k: str(k.name)):
                rslt += obj.get_sql_for('create') + ';\n'

        if 'procedure' in prms:
            rslt += fancy_header('PROCEDURES : first pass')
            rslt += 'SET TERM ^;\n'
            for obj in sorted(appconf.con[db].procedures, key=lambda k: str(k.name)):
                rslt += obj.get_sql_for('create', no_code=True) + '^\n\n'
            rslt += 'SET TERM ;^\n'

        if 'table' in prms:
            rslt += fancy_header('TABLES')
            for obj in sorted(appconf.con[db].tables, key=lambda k: str(k.name)):
                rslt += obj.get_sql_for('create') + ';\n\n'

        if 'view' in prms:
            rslt += fancy_header('VIEWS')
            for obj in sorted(appconf.con[db].views, key=lambda k: str(k.name)):
                rslt += obj.get_sql_for('create') + ';\n\n'

        #Constraints !
        if 'table' in prms:
            _ck = ''
            _uq = ''
            _fk = ''
            for obj in sorted(appconf.con[db].constraints, key=lambda k: str(k.name)):
                if obj.ischeck():
                    _ck += obj.get_sql_for('create') + ';\n'
                if obj.isunique():
                    _uq += obj.get_sql_for('create') + ';\n'
                if obj.isfkey():
                    _fk += obj.get_sql_for('create') + ';\n'

            if _ck:
                rslt += fancy_header('CHECK CONSTRAINTS')
                rslt += _ck
            if _uq:
                rslt += fancy_header('UNIQUE CONSTRAINTS')
                rslt += _uq
            if _fk:
                rslt += fancy_header('FOREIGN KEY CONSTRAINTS')
                rslt += _fk

        if 'index' in prms:
            rslt += fancy_header('INDICES')
            for obj in sorted(appconf.con[db].indices, key=lambda k: str(k.name)):
                rslt += obj.get_sql_for('create') + ';\n\n'

        if 'trigger' in prms:
            _dt = ''
            _tt = ''

            for obj in sorted(appconf.con[db].triggers, key=lambda k: str(k.name)):
                if obj.isdbtrigger():
                    _dt += obj.get_sql_for('create') + '^\n\n'
                else:
                    _tt += obj.get_sql_for('create') + '^\n\n'

            if _dt:
                rslt += fancy_header('DATABASE TRIGGERS')
                rslt += 'SET TERM ^;\n'
                rslt += _dt
                rslt += 'SET TERM ;^\n'

            if _tt:
                rslt += fancy_header('TABLE TRIGGERS')
                rslt += 'SET TERM ^;\n'
                rslt += _tt
                rslt += 'SET TERM ;^\n'

        if 'procedure' in prms:
            rslt += fancy_header('PROCEDURES : second pass')
            rslt += 'SET TERM ^;\n'
            for obj in sorted(appconf.con[db].procedures, key=lambda k: str(k.name)):
                rslt += obj.get_sql_for('alter') + '^\n\n'
            rslt += 'SET TERM ;^\n'

        if 'role' in prms:
            rslt += fancy_header('ROLES')
            for obj in sorted(appconf.con[db].roles, key=lambda k: str(k.name)):
                rslt += obj.get_sql_for('create') + ';\n'

        if 'grant' in prms:
            rslt += fancy_header('PRIVILEGES')
            for obj in sorted(appconf.con[db].privileges, key=lambda k: str(k.name)):
                rslt += obj.get_sql_for('grant') + ';\n'


        return render('db_metadata_result', db=db, ddl_sql=rslt)




@baseApp.route('/db/create', method=['GET', 'POST'])
def db_create():
    if request.method == 'GET':

        _reg = {
            'db_alias': '',
            'db_server': '',
            'db_path': '',
            'db_user': '',
            'db_pass': '',
            'db_role': '',
            'dialect': '',
            'charset': ''
        }

        return render(tpl='db_register', reg=_reg, ftyp='create')
    else:
        prms = request.POST

        if prms['db_path'] in ['BASE_PATH', '', '.', './']:
            prms['db_path'] = appconf.basepath

        sql = """
            create database
                '{db_server}:{db_path}/{db_name}'
                user '{db_user}'
                password '{db_pass}'
                page_size  {db_page_size}
                DEFAULT CHARACTER SET {charset}""".format(**prms)

        appconf.con[prms.db_alias] = fdb.create_database(
            sql=sql,
            connection_class=fdb.ConnectionWithSchema,
        )

        register_ddl(prms.db_alias)

        appconf.db_config[prms.db_alias] = {
            'db_server': prms.db_server,
            'db_path': prms.db_path + '/' + prms.db_name,
            'db_user': prms.db_user,
            'db_pass': prms.db_pass,
            'db_role': prms.db_role,
            'dialect': 3, #todo! prms.dialect,
            'charset': prms.charset
        }
        with open('%s/dbconfig.ini' % appconf.basepath, 'w+', encoding='utf-8') as f:
            appconf.db_config.write(f)

        redirect('/db/list')

@baseApp.route('/db/drop', method=['GET', 'POST'])
def db_drop():
    if 'db' in request.GET:
        db = request.GET.db
        if db not in appconf.con:
            connect_db(db)

        appconf.con[db].drop_database()
        appconf.con.pop(db, None)
        appconf.ddl.pop(db, None)
        appconf.db_config.pop(db, None)

        redirect('/db/list')
    else:
        return render(tpl='db_drop')


@baseApp.route('/db/list')
def db_list():
    return render('db_list')


@baseApp.route('/db/<db>')
def db_page(db):
    if db not in appconf.con:
        connect_db(db)

    s = request.environ['beaker.session']

    return render('db_page', db=db)

@baseApp.route('/db/<typ>/<db>')
def dobj_list(typ, db):
    if db not in appconf.con:
        connect_db(db)

    _rnd = 'd' + typ
    if typ == 'domains':
        _ddl = appconf.con[db].domains
    elif typ == 'indices':
        _ddl = appconf.con[db].indices
    elif typ == 'sequences':
        _ddl = appconf.con[db].sequences
    elif typ == 'constraints':
        _ddl = appconf.con[db].constraints
    elif typ == 'exceptions':
        _ddl = appconf.con[db].exceptions

    return render(_rnd, db=db, tbl=_ddl, typ=typ)

@baseApp.route('/db/<typ>/<db>/<obj>')
def dbobj(typ, db, obj):
    if db not in appconf.con:
        connect_db(db)

    _rnd = 'd' + typ
    if typ == 'table':
        _ddl = appconf.con[db].schema.get_table(obj)
    elif typ == 'view':
        _ddl = appconf.con[db].schema.get_view(obj)
    elif typ == 'trigger':
        _ddl = appconf.con[db].schema.get_trigger(obj)
    elif typ == 'procedure':
        _ddl = appconf.con[db].schema.get_procedure(obj)
    elif typ == 'function':
        _ddl = appconf.con[db].schema.get_function(obj)

    return render(_rnd, db=db, tbl=_ddl, obj=obj, typ=typ)


