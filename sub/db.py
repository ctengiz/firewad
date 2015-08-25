""" 
Database objects and DDL operations
"""

import io
import base64
from collections import OrderedDict
import json

import fdb
import fdb.schema

from bottle import request, redirect, HTTPError, template

from common import baseApp, appconf, render, formval_to_utf8, serve_file


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
    appconf.mon[db] = OrderedDict()

    register_ddl(db)


@baseApp.route('/db/close/<db>')
def db_register(db):
    appconf.con[db].close()
    appconf.con.pop(db)
    appconf.mon.pop(db)
    appconf.ddl.pop(db)
    redirect('/')

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
    else:
        appconf.con[db].schema.reload()

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

        rslt = fancy_header('DATABASE DDL EXTRACT OF : ** %s **' %db)

        #Database Create or Connect !
        if 'include_password' in prms:
            _password = "PASSWORD '%s'" % appconf.db_config[db]['db_pass']
        else:
            _password = ''
        if prms.create_or_connect == 'create':
            _cr = "CREATE DATABASE '{db_server}:{db_path}'\nUSER '{db_user}' {password}\nPAGE_SIZE {page_size}\nDEFAULT CHARACTER SET UTF8;"

            rslt += _cr.format(
                password= _password,
                page_size = appconf.con[db].db_info(fdb.isc_info_page_size),
                **appconf.db_config[db])
        elif prms.create_or_connect == 'connect':
            _cr = "CONNECT '{db_server}:{db_path}'\nUSER '{db_user}' {password};"
            rslt += _cr.format(
                password= _password,
                page_size = appconf.con[db].db_info(fdb.isc_info_page_size),
                **appconf.db_config[db])

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
                rslt += obj.get_sql_for('create_or_alter') + '^\n\n'
            rslt += 'SET TERM ;^\n'

        if 'role' in prms:
            rslt += fancy_header('ROLES')
            for obj in sorted(appconf.con[db].roles, key=lambda k: str(k.name)):
                if not obj.issystemobject():
                    rslt += obj.get_sql_for('create') + ';\n'

        #todo: check this
        if 'grant' in prms:
            rslt += fancy_header('PRIVILEGES')
            for obj in appconf.con[db].privileges:
                if obj.user_name != 'SYSDBA' and \
                        (obj.user_type == 8
                         or obj.user_type == 13):
                    rslt += obj.get_sql_for('grant') + ';\n'

        #todo: extract descriptions too !
        #if 'description' in prms:
            #.........

        if prms.output == 'script':
            #todo: if script is too long, we get a 414 error. So we should find another way...
            #possible solutions:
            #  a. work with a temp file
            #  b. on the fly gzip encoded string (may also get a 414 error)
            _bs = base64.urlsafe_b64encode(bytes(rslt, 'utf-8'))
            redirect('/tools/script/%s?encoded&sql=%s' % (db, _bs))
        elif prms.output == 'file':
            _data = io.StringIO(rslt)
            return serve_file(db+'.sql', data=_data, download=True)
        else:
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

    s['db'] = db
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
    elif typ == 'tables':
        _ddl = appconf.con[db].tables
    elif typ == 'views':
        _ddl = appconf.con[db].views
    elif typ == 'procedures':
        _ddl = appconf.con[db].procedures
    elif typ == 'triggers':
        _ddl = appconf.con[db].triggers
    elif typ == 'roles':
        _ddl = appconf.con[db].roles

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
    elif typ == 'exception':
        _ddl = appconf.con[db].schema.get_exception(obj)
    elif typ == 'domain':
        _ddl = appconf.con[db].schema.get_domain(obj)
    elif typ == 'sequence':
        _ddl = appconf.con[db].schema.get_sequence(obj)
    elif typ == 'index':
        _ddl = appconf.con[db].schema.get_index(obj)
    elif typ == 'constraint':
        _ddl = appconf.con[db].schema.get_constraint(obj)
    elif typ == 'role':
        _ddl = appconf.con[db].schema.get_role(obj)

    return render(_rnd, db=db, tbl=_ddl, obj=obj, typ=typ)


@baseApp.route('/backup', method=['GET', 'POST'])
def db_backup():
    if request.method == 'GET':
        return template('db_br_backup', db="")
    else:
        db = request.POST.db

        scon = fdb.services.connect(host=appconf.db_config[db]['db_server'],
                                   user=appconf.db_config[db]['db_user'],
                                   password=appconf.db_config[db]['db_pass']
                                   )

        backup_path = request.POST.backup_path
        can_downlod = False

        if backup_path == './static/backup':
            backup_path = appconf.basepath + '/static/backup'
            can_downlod = True

        if backup_path[-1] != "/":
            backup_path += '/'

        backup_file = backup_path + request.POST.backup_name

        try:
            scon.backup(source_database=appconf.db_config[db]['db_path'],
                       dest_filenames=backup_file,
                       #dest_file_sizes=(),
                       ignore_checksums=int(request.POST.pop('ignore_checksums', 0)),
                       ignore_limbo_transactions=int(request.POST.pop('ignore_limbo_transactions', 0)),
                       metadata_only=int(request.POST.pop('metadata_only', 0)),
                       collect_garbage=int(request.POST.pop('collect_garbage', 0)),
                       transportable=int(request.POST.pop('transportable', 0)),
                       convert_external_tables_to_internal=int(request.POST.pop('convert_external_to_internal', 0)),
                       compressed=int(request.POST.pop('compressed', 0)),
                       no_db_triggers=int(request.POST.pop('no_db_triggers', 0))
                       )

            rpt = '\n'.join(scon.readlines())
            lnk = ""
            if can_downlod:
                lnk = '<a href="/static/backup/%s">Your backup is ready for download</a>' %(request.POST.backup_name)

            return json.dumps({
                "success": 1,
                "report":rpt,
                "link": lnk
            })
        except Exception as err:
            return json.dumps({"success":0, "message":str(err)})
        finally:
            scon.close()


@baseApp.route('/restore', method=['GET', 'POST'])
def db_restore():

    if request.method == 'GET':
        return template('db_br_restore', db="")
    else:

        restore_target = request.POST.restore_target

        if restore_target == "registered":
            dest_db = request.POST.dest_db
            dest_filename = appconf.db_config[dest_db]['db_path']

            _server=appconf.db_config[dest_db]['db_server']
            _user=appconf.db_config[dest_db]['db_user']
            _pass=appconf.db_config[dest_db]['db_pass']

        else:
            dest_filename = request.POST.dest_filename

            _server = request.POST.dest_server
            _user = 'SYSDBA'
            _pass = request.POST.passw

        source_filename = request.POST.source_filename.replace('./static/backup', appconf.basepath + '/static/backup')

        scon = fdb.services.connect(host=_server,
                                    user=_user,
                                    password=_pass
                                    )

        try:
            scon.restore(source_filenames=source_filename,
                         dest_filenames=dest_filename,
                         #todo: dest_file_pages=int(request.POST.pop('dest_file_pages', 8192)),
                         page_size=int(request.POST.pop('page_size', 8192)),
                         #todo: cache_buffers=int(request.POST.pop('cache_buffers', 8192)),
                         access_mode_read_only=int(request.POST.pop('access_mode_read_only', 0)),
                         replace=int(request.POST.pop('replace', 0)),
                         deactivate_indexes=int(request.POST.pop('deactivate_indexes', 0)),
                         do_not_restore_shadows=int(request.POST.pop('do_not_restore_shadows', 0)),
                         do_not_enforce_constraints=int(request.POST.pop('do_not_enforce_constraints', 0)),
                         commit_after_each_table=int(request.POST.pop('commit_after_each_table', 0)),
                         use_all_page_space=int(request.POST.pop('use_all_page_space', 1)),
                         no_db_triggers=int(request.POST.pop('no_db_triggers', 0)),
                         metadata_only=int(request.POST.pop('metadata_only', 0))
                         )

            rpt = '\n'.join(scon.readlines())
            lnk = ""

            return json.dumps({
                "success": 1,
                "report":rpt,
                "link": lnk
            })
        except Exception as err:
            return json.dumps({"success":0, "message":str(err)})
        finally:
            scon.close()

