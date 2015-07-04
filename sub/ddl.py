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

@baseApp.route('/ddl/<db>', method=['GET', 'POST'])
def ddl_opr(db):
    pass
