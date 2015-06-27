""" 
Sql Query, Browse Data and other DML operations
"""

import json
import base64
import datetime
import decimal

import fdb
from bottle import request, redirect, HTTPError, template
from sub.db import connect_db

from common import baseApp, appconf, render

def process_val(cval):

    return_val = cval

    type_ = type(cval)

    if cval is None:
        return_val = ''
    else:
        if type_ in base64.bytes_types:
            return_val = base64.b64encode(cval).decode("utf-8")
        elif type_ is datetime.date:
            return_val = cval.strftime('%d.%m.%Y')
        elif type_ is datetime.datetime:
            return_val = cval.strftime('%d.%m.%Y %H:%M')
        elif type_ is decimal.Decimal:
            return_val = str(cval)

    return return_val


@baseApp.route('/tools/query/<db>', method=['GET', 'POST'])
def query(db):
    if db not in appconf.con:
        connect_db(db)

    _template = 'query-bootstrap-table'
    _template = 'query-raw'

    if request.method == 'GET':
        return template(_template, db=db)
    else:
        sql = request.POST.sql
        crs = appconf.con[db].cursor()
        crs.execute(sql)

        columns = []
        for _fld in crs.description:
            columns.append(
                {'field': _fld[0],
                 'title': _fld[0].replace('_', ' ').title(),
                 'sortable': True,
                 'filterControl': 'input'
                 }
            )
            """
            _fld_def['type_code'] = _fld[1]
            _fld_def['display_size'] = _fld[2]
            _fld_def['internal_size'] = _fld[3]
            _fld_def['precision'] = _fld[4]
            _fld_def['scale'] = _fld[5]
            _fld_def['null_ok'] = _fld[6]
            fields.append(_fld_def)
            """

        data = []
        for row in crs.fetchallmap():
            jrw = {}
            for k in row:
                print(k, row[k], type(row[k]).__name__, type(row[k]))
                json.dumps({k: process_val(row[k])})
                jrw[k] = process_val(row[k])
            data.append(jrw)

        return json.dumps({'columns': columns, 'data': data})

