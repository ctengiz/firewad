""" 
Database Monitoring
"""

import json
import base64
import datetime
import decimal
import re

import fdb
from bottle import request, redirect, HTTPError, template, response
from sub.db import connect_db

from common import baseApp, appconf, render, formval_to_utf8


def create_mon_session(db):
    _mon = fdb.monitor.Monitor()
    _mon.bind(appconf.con[db])
    _mon_key = datetime.datetime.now().strftime('%y%m%d_%H%M%S')
    appconf.mon[db][_mon_key] = _mon
    return _mon, _mon_key


@baseApp.route('/mon/<db>')
def mon_session(db):
    if db not in appconf.con:
        connect_db(db)

    if not appconf.mon[db]:
        mon, mon_key = create_mon_session(db)
    else:
        mon_key = next(reversed(appconf.mon[db]))
        mon = appconf.mon[db][mon_key]

    return template('mon', db=db, mon_template='./incmon/mn_database.tpl', mon=mon, mon_key=mon_key, data=mon.db)


@baseApp.route('/mon/<db>/monopr')
def mon_opr(db):
    prms = request.GET
    if prms.opr == 'new':
        mon, mon_key = create_mon_session(db)
    elif prms.opr == 'del':
        appconf.mon[db].pop(prms.mon_key, None)
        if not appconf.mon[db]:
            mon, mon_key = create_mon_session(db)
        else:
            mon_key = next(reversed(appconf.mon[db]))
            mon = appconf.mon[db][mon_key]

    return template('mon', db=db, mon_template='./incmon/mn_database.tpl', mon=mon, mon_key=mon_key, data=mon.db)


@baseApp.route('/mon/<db>/info/<info>/<mon_key>', method=['GET', 'POST'])
def mon_info(db, info, mon_key):
    prms = request.GET

    if db not in appconf.con:
        connect_db(db)

    try:
        mon = appconf.mon[db][mon_key]
    except KeyError:
        HTTPError(500, 'Monitor key is invalid. Create new monitor key.')

    if info == 'database':
        data = mon.db
    elif info == 'attachments':
        data = mon.attachments
    elif info == 'transactions':
        if 'attachment' in prms:
            data = mon.get_attachment(int(prms.attachment)).transactions
        else:
            data = mon.transactions
    elif info == 'statements':
        if 'attachment' in prms:
            data = mon.get_attachment(int(prms.attachment)).statements
        elif 'transaction' in prms:
            data = mon.get_transaction(int(prms.transaction)).statements
        else:
            data = mon.statements
    elif info == 'callstack':
        """
        if 'attachment' in prms:
            data = mon.get_attachment(int(prms.attachment)).callstack
        elif 'transaction' in prms:
            data = mon.get_transaction(int(prms.transaction)).iostats
        """
        if 'statement' in prms:
            data = mon.get_statement(int(prms.statement)).callstack
        else:
            data = mon.callstack

    elif info == 'variables':
        if 'attachment' in prms:
            data = mon.get_attachment(int(prms.attachment)).variables
        elif 'transaction' in prms:
            data = mon.get_transaction(int(prms.transaction)).variables
        else:
            data = mon.variables

    elif info == 'iostats':
        if 'attachment' in prms:
            data = mon.get_attachment(int(prms.attachment)).iostats
        elif 'transaction' in prms:
            data = mon.get_transaction(int(prms.transaction)).iostats
        elif 'statement' in prms:
            data = mon.get_statement(int(prms.statement)).iostats
        elif 'callstack' in prms:
            data = mon.get_call(int(prms.callstack)).iostats
        else:
            data = mon.iostats

    return template('mon',
                    db=db,
                    mon_template='./incmon/mn_%s.tpl' % info,
                    mon=mon,
                    mon_key=mon_key,
                    data=data,
                    collapsed=False,
                    table_id=info)




