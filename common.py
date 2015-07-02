__author__ = 'cagataytengiz'

import configparser
import mimetypes
import datetime
import os
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


def formval_to_utf8(aval):
    return aval.encode('latin1').decode('utf8')


def serve_file(filename, data=None, mimetype='auto', download=False, charset='UTF-8'):
    headers = dict()

    if mimetype == 'auto':
        mimetype, encoding = mimetypes.guess_type(filename)
        if encoding: headers['Content-Encoding'] = encoding

    if mimetype:
        if mimetype[:5] == 'text/' and charset and 'charset' not in mimetype:
            mimetype += '; charset=%s' % charset
        headers['Content-Type'] = mimetype

    if download:
        headers['Content-Disposition'] = 'attachment; filename="%s"' % filename

    data.seek(0, os.SEEK_END)
    clen = data.tell()
    headers['Content-Length'] = clen
    lm = datetime.datetime.now().strftime("%a, %d %b %Y %H:%M:%S GMT")
    headers['Last-Modified'] = lm

    if bottle.request.method == 'HEAD':
        body = ''
    else:
        data.seek(0)
        body = data.read()

    headers["Accept-Ranges"] = "bytes"
    ranges = bottle.request.environ.get('HTTP_RANGE')
    if 'HTTP_RANGE' in bottle.request.environ:
        ranges = list(bottle.parse_range_header(bottle.request.environ['HTTP_RANGE'], clen))
        if not ranges:
            return bottle.HTTPError(416, "Requested Range Not Satisfiable")
        offset, end = ranges[0]
        headers["Content-Range"] = "bytes %d-%d/%d" % (offset, end - 1, clen)
        headers["Content-Length"] = str(end - offset)
        if body:
            body = bottle._file_iter_range(body, offset, end - offset)
        return bottle.HTTPResponse(body, status=206, **headers)
    return bottle.HTTPResponse(body, **headers)

