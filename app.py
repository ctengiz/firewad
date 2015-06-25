__author__ = 'cagataytengiz'

import os
import importlib

from bottle import BaseTemplate, debug, run, template, static_file, request, redirect
from beaker.middleware import SessionMiddleware

from common import appconf, baseApp, init_app, init_session, render, highlight_sql, get_rdb_type
import firstrun


def run_app(do_debug=True):

    appconf.basepath = os.path.abspath(os.path.dirname(__file__))

    if not(os.path.exists(appconf.basepath + '/config.ini')):
        baseApp.route('/', method=['GET', 'POST'], callback=firstrun.do_setup)
        baseApp.route('/setup_ok', method=['GET', 'POST'], callback=firstrun.setup_ok)
    else:
        init_app()
        baseApp.route('/', method=['GET', 'POST'], callback=index)

    #template defaults
    BaseTemplate.defaults['appconf'] = appconf
    BaseTemplate.defaults['highlight_sql'] = highlight_sql
    BaseTemplate.defaults['get_rdb_type'] = get_rdb_type

    #Importing controllers
    _controllers_dir = '%s/sub/' %(appconf.basepath, )
    _lst = os.listdir(_controllers_dir)
    for _fname in _lst:
        _module_name, _module_ext = os.path.splitext(_fname)
        _module_path = 'sub.' + _module_name
        if not os.path.isdir(_module_path) and _fname[0:2] != '__' and _module_ext == '.py':
            module = importlib.import_module(_module_path)

        #baseApp.merge(module.subApp.routes)

    return SessionMiddleware(baseApp, {'session.type': 'file',
                                       'session.cookie_expires': 18000,
                                       'session.data_dir': appconf.basepath + '/sessions',
                                       'session.auto': True})

@baseApp.hook('before_request')
def setup_request():
    s = request.environ['beaker.session']
    _path = request.urlparts.path.split('/')[1]

    if 'logged_in' not in s:
        init_session()

    BaseTemplate.defaults['session'] = s

    if appconf.login_required and s['logged_in'] is False and _path != 'login':
        redirect('/login')


def index():
    """

    :return:
    """

    return render()


@baseApp.get('/static/<filepath:path>')
def server_static(filepath):
    """

    :param filepath:
    :return:
    """
    return static_file(filepath, root='%s/static' % appconf.basepath)




if __name__ == '__main__':
    run_app()
    debug(True)
    appM = run_app()
    run(app=appM, host="127.0.0.1", port=18022, reloader=False)
else:
    appM = run_app()
    application = appM


