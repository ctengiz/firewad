__author__ = 'cagataytengiz'

import os

from bottle import BaseTemplate, debug, run, template, static_file, request
from beaker.middleware import SessionMiddleware

from common import appconf, baseApp
import setup


def run_app(do_debug=True):

    appconf.basepath = os.path.abspath(os.path.dirname(__file__))

    if not(os.path.exists(appconf.basepath + '/config.ini')):
        baseApp.route('/', method=['GET', 'POST'], callback=setup.do_setup)
        baseApp.route('/setup_ok', method=['GET', 'POST'], callback=setup.setup_ok)
    else:
        #todo: init_app()
        baseApp.route('/', method=['GET', 'POST'], callback=index)

    #template defaults
    BaseTemplate.defaults['appconf'] = appconf

    return SessionMiddleware(baseApp, {'session.type': 'file',
                                       'session.cookie_expires': 18000,
                                       'session.data_dir': appconf.basepath + '/sessions',
                                       'session.auto': True})

@baseApp.hook('before_request')
def setup_request():
    s = request.environ['beaker.session']

    #todo:
    s['db_code'] = ''
    """
    if not 'logged_in' in s:
        utils.init_session()
    request.session = s


    dst_path = request.urlparts.path.split('/')[1]
    if baseApp.config['auth.login_required'] == '1':
        if not(s.get('logged_in')):
            if dst_path != 'login' and dst_path != 'static':
                s['path'] = request.urlparts.path
                redirect('/login')

    if dst_path == 'admin':
        if not(s.get('is_admin')):
            abort(401, _('Admin rights required for this section'))
    """

    BaseTemplate.defaults['session'] = s



def index():
    """

    :return:
    """
    #todo: burada tüm prj'leri listeleyelim !
    #veya tam bir welcome ekranı koyalım
    #işte hoş geldiniz şu projeler vardır. admin şuradandır vs..

    return template('_content', content='', scripts='')


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


