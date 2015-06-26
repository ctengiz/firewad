""" 
Database objects and DDL operations
"""

import fdb
from bottle import request, redirect, HTTPError

from common import baseApp, appconf, render

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

    appconf.ddl[db] = {}
    appconf.ddl[db]['tables'] = sorted([t.name for t in appconf.con[db].tables])
    appconf.ddl[db]['tables_id'] = {}
    for t in appconf.con[db].tables:
        appconf.ddl[db]['tables_id'][t.id] = t.name

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


@baseApp.route('/register_db', method=['GET', 'POST'])
def register_db():
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
            _db = request.GET['db'].encode('latin1').decode('utf8')
            for k in _reg:
                _reg[k] = appconf.db_config[_db][k]
            _reg['db_alias'] = _db
        else:
            _reg['db_alias'] = ''

        return render(tpl='register_db', reg=_reg)
    else:
        prms = request.POST

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

        redirect('/db_list')


@baseApp.route('/db_list')
def db_list():
    return render('db_list')


@baseApp.route('/db/<db>')
def db_page(db):
    if db not in appconf.con:
        connect_db(db)

    s = request.environ['beaker.session']

    return render('db_page', db=db)

@baseApp.route('/<typ>/<db>')
def dtable(typ, db):
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

@baseApp.route('/<typ>/<db>/<obj>')
def dtable(typ, db, obj):
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


