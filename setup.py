__author__ = 'cagataytengiz'

import configparser

import bottle

from common import appconf, baseApp

def do_setup():
    """

    :return:
    """

    if bottle.request.method == 'GET':
        return bottle.template('setup')
    else:
        prms = bottle.request.POST

        if prms['db_path'] in ['BASE_PATH', '', '.', './']:
            prms['db_path'] = appconf.basepath

        aconfig = configparser.ConfigParser()
        aconfig['database'] = {
            'db_server': prms['db_server'],
            'db_path': prms['db_path'],
            'db_user': prms['db_user'],
            'db_pass': prms['db_pass'],
            'charset': prms['charset']
        }
        with open('%s/config.ini' % appconf.basepath, 'w+', encoding='utf-8') as f:
            aconfig.write(f)

        prms['db_name'] = 'meta.fdb'

        bottle.redirect('/setup_ok')


def setup_ok():
    from app import index
    #todo: from apps.system import init_app

    #init_app()

    baseApp.route('/', method=['GET', 'POST'], callback=index)
    return bottle.template('setup_ok')
