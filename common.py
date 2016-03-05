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

class Constants:
    field_types = OrderedDict([
        ('SMALLINT', {'show': ''}),
        ('INTEGER', {'show': ''}),
        ('BIGINT', {'show': ''}),
        ('FLOAT', {'show': ''}),
        ('DOUBLE PRECISION', {'show': ''}),
        ('NUMERIC', {'show': '.prop-numeric'}),
        ('DECIMAL', {'show': '.prop-numeric'}),
        ('DATE', {'show': ''}),
        ('TIME', {'show': ''}),
        ('TIMESTAMP',{'show': ''}),
        ('CHAR', {'show': '.prop-char'}),
        ('VARCHAR', {'show': '.prop-char'}),
        ('BLOB', {'show': '.prop-blob'})
    ])

    charsets = OrderedDict([
        ('NONE', ['']),
        ('UTF8', ['', 'UCS_BASIC', 'UNICODE', 'UNICODE_CI', 'UNICODE_CI_AI', 'UTF8']),
        ('UNICODE_FSS', ['', 'UNICODE_FSS']),
        ('ASCII', ['', 'ASCII']),
        ('BIG_5', ['', 'BIG5']),
        ('CP943C', ['', 'CP943C', 'CP943C_UNICODE']),
        ('CYRL', ['', 'CYRL', 'DB_RUS', 'PDOX_CYRIL']),
        ('DOS437', ['', 'DB_DEU437', 'DB_ESP437', 'DB_FIN437', 'DB_FRA437', 'DB_ITA437', 'DB_NLD437']),
        ('DOS737', ['', 'DOS737']),
        ('DOS775', ['', 'DOS775']),
        ('DOS850', ['', 'DB_DEU850', 'DB_ESP850', 'DB_FRA850', 'DB_FRC850', 'DB_ITA850', 'DB_NLD850']),
        ('DOS852', ['', 'DB_CSY', 'DB_PLK', 'DB_SLO', 'DOS852', 'PDOX_CSY', 'PDOX_HUN']),
        ('DOS857', ['', 'DB_TRK', 'DOS857']),
        ('DOS858', ['', 'DOS858']),
        ('DOS860', ['', 'DB_PTG860', 'DOS860']),
        ('DOS861', ['', 'DOS861', 'PDX_ISL']),
        ('DOS862', ['', 'DOS862']),
        ('DOS863', ['', 'DB_FRC863', 'DOS863']),
        ('DOS864', ['', 'DOS864']),
        ('DOS865', ['', 'DB_DAN865', 'DB_NOR865', 'DOS865', 'PDOX_NORDAN4']),
        ('DOS866', ['', 'DOS866']),
        ('DOS869', ['', 'DOS869']),
        ('EUCJ_0208', ['', 'EUCJ_0208']),
        ('GB18030', ['', 'GB18030', 'GB18030_UNICODE']),
        ('GBK', ['', 'GBK', 'GBK_UNICODE']),
        ('GB_2312', ['', 'GB_2312']),
        ('ISO8859_1', ['', 'DA_DA', 'DE_DE', 'DU_NL', 'EN_UK', 'EN_US', 'ES_ES']),
        ('ISO8859_2', ['', 'CS_CZ', 'ISO8859_2', 'ISO_HUN', 'ISO_PLK']),
        ('ISO8859_3', ['', 'ISO8859_3']),
        ('ISO8859_4', ['', 'ISO8859_4']),
        ('ISO8859_5', ['', 'ISO8859_5']),
        ('ISO8859_6', ['', 'ISO8859_6']),
        ('ISO8859_7', ['', 'ISO8859_7']),
        ('ISO8859_8', ['', 'ISO8859_8']),
        ('ISO8859_9', ['', 'ISO8859_9']),
        ('ISO8859_13', ['', 'ISO8859_13', 'LT_LT']),
        ('KOI8R', ['', 'KOI8R', 'KOI8R_RU']),
        ('KOI8U', ['', 'KOI8U', 'KOI8R_UA']),
        ('KSC_5601', ['', 'KSC_5601', 'KSC_DICTIONARY']),
        ('NEXT', ['', 'NEXT', 'NXT_DEU', 'NXT_ESP', 'NXT_FRA', 'NXT_ITA', 'NXT_US']),
        ('OCTETS', ['', 'OCTETS']),
        ('SJIS_0208', ['', 'SJIS_0208']),
        ('TIS620', ['', 'TIS620']),
        ('WIN1250', ['', 'BS_BA', 'PXW_CSY', 'PXW_HUN', 'PXW_HUNDC', 'PXW_PLK', 'PXW_SLOV']),
        ('WIN1251', ['', 'PXW_CYRL', 'WIN1251', 'WIN1251_UA']),
        ('WIN1252', ['', 'PXW_INTL', 'PXW_INTL', 'PXW_INTL850', 'PXW_NORDAN4', 'PXW_SPAN', 'PXW_SWEDFIN', 'WIN1252']),
        ('WIN1253', ['', 'PXW_GREEK', 'WIN1253']),
        ('WIN1254', ['', 'PXW_TURK', 'WIN1254']),
        ('WIN1255', ['', 'WIN1255']),
        ('WIN1256', ['', 'WIN1256']),
        ('WIN1257', ['', 'WIN1257', 'WIN1257_EE', 'WIN1257_LT', 'WIN1257_LV']),
        ('WIN1258', ['', 'WIN1258']),
    ])



class appconf():
    login_required = False
    basepath = None
    con = OrderedDict()
    trn = OrderedDict()
    ddl = OrderedDict()
    mon = OrderedDict()
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

