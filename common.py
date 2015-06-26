__author__ = 'cagataytengiz'

import configparser
from collections import OrderedDict

import bottle
from pygments import highlight
from pygments.lexers import sql
from pygments.formatters import html


baseApp = bottle.Bottle()

class appconf():
    login_required = False
    basepath = None
    con = OrderedDict()
    ddl = OrderedDict()
    db_config = configparser.ConfigParser()


def init_session():
    s = bottle.request.environ.get('beaker.session')
    s['logged_in'] = False
    s['db'] = ''


def init_app():
    aconfig = configparser.ConfigParser()

    with open('%s/config.ini' % appconf.basepath, 'r', encoding='utf-8') as f:
        aconfig.read_file(f)
    appconf.login_required = aconfig['system']['login_required'] == 1

    #todo: better exc. handling
    try:
        with open('%s/dbconfig.ini' % appconf.basepath, 'r', encoding='utf-8') as f:
            appconf.db_config.read_file(f)
    except:
        pass


def render(tpl='', scripts='', show_topbar=True, show_sidebar=True, **kwargs):
    if tpl:
        content = bottle.template(tpl, **kwargs)
    else:
        content = ''
    return bottle.template('base',
                           content=content,
                           scripts=scripts,
                           show_topbar=show_topbar,
                           show_sidebar=show_sidebar,
                           **kwargs
                           )

def highlight_sql(text):
    return highlight(text, sql.PlPgsqlLexer(), html.HtmlFormatter())


def get_rdb_type(typ):
    types = ['table', 'view', 'trigger', 'computed field', 'validation', 'procedure',
             'expression index', 'exception', 'user', 'field', 'index', ' ',
             'user group', 'role', 'generator', 'udf', 'blob filter']

    return types[typ]

