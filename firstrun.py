__author__ = 'cagataytengiz'

import configparser
from common import init_app

import bottle

from common import appconf, baseApp

def do_setup():
    """

    :return:
    """

    #todo: setup
    """
    if bottle.request.method == 'GET':
        return bottle.template('setup')
    else:
        prms = bottle.request.POST

        aconfig = configparser.ConfigParser()
        aconfig['system'] = {
            'login_required': prms.get('login_required', default = 0),
        }
        with open('%s/config.ini' % appconf.basepath, 'w+', encoding='utf-8') as f:
            aconfig.write(f)

        bottle.redirect('/setup_ok')
    """

    aconfig = configparser.ConfigParser()
    aconfig['system'] = {
        'login_required': 0,
    }
    with open('%s/config.ini' % appconf.basepath, 'w+', encoding='utf-8') as f:
        aconfig.write(f)
    from app import index
    init_app()
    baseApp.route('/', method=['GET', 'POST'], callback=index)
    return index()



def setup_ok():
    from app import index

    init_app()

    baseApp.route('/', method=['GET', 'POST'], callback=index)
    return bottle.template('setup_ok')
