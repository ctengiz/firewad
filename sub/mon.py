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
    _mon_key = datetime.datetime.now().strftime('%d.%m.%Y %H:%M')
    _mon = fdb.monitor.Monitor()
    _mon.bind(appconf.con[db])
    appconf.mon[db][_mon_key] = _mon


@baseApp.route('/mon/<db>', method=['GET', 'POST'])
def mon_session(db):
    if db not in appconf.con:
        connect_db(db)

    if request.method == 'GET':
        create_mon_session(db)
        return template('mon', db=db, mon_template='')


@baseApp.route('/mon/<db>/info/<info>/<mon_key>', method=['GET', 'POST'])
def mon_info(db, info, mon_key):
    if db not in appconf.con:
        connect_db(db)

    try:
        mon = appconf.mon[db][mon_key]
    except KeyError:
        HTTPError(500, 'Monitor key is invalid. Create new monitor key.')

    return template('mon', db=db, mon_template='./incmon/mn_%s.tpl' %info, mon=mon)




