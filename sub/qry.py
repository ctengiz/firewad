""" 
Sql Query, Browse Data and other DML operations
"""

import fdb
from bottle import request, redirect, HTTPError, template
from sub.db import connect_db

from common import baseApp, appconf, render

@baseApp.route('/tools/query/<db>', method=['GET', 'POST'])
def query(db):
    if db not in appconf.con:
        connect_db(db)

    if request.method == 'GET':
        return template('query', db=db)
        #return render(tpl='query', db=db)
