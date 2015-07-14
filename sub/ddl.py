"""
DDL Operations
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

@baseApp.route('/ddl/new/table/<db>', method=['GET', 'POST'])
def ddl_new_table(db):
    if db not in appconf.con:
        connect_db(db)

    if request.method == 'GET':
        return template('ddl_table', db=db)




