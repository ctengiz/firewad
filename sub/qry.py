""" 
Sql Query, Browse Data and other DML operations
"""

import fdb
from bottle import request, redirect, HTTPError

from common import baseApp, appconf, render


def query():
    pass