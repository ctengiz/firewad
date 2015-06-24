""" 
Description of the module
"""

def login(**prms):
    s = request.environ['beaker.session']
    if s['logged_in']:
        redirect('/')

    if request.method == 'GET':
        return template('./core/login')
    else:
        sql = "select * from usr where code = ? and pass = ?"
        crs = appconf.metacon.cursor()
        crs.execute(sql, (prms['code'], prms['upass']))
        rw = crs.fetchonemap()
        if rw:
            s['usr_idx'] = rw['idx']
            s['usr_code'] = rw['code']
            s['is_admin'] = rw['is_admin'] == 1
            s['logged_in'] = True

            _url = s['redirect']
            s['redirect'] = '/'

            redirect(_url)
        else:
            #todo: wrong password !
            return template('./core/login', login_invalid=True)


def logout():
    init_session()
    refresh_session_menu()
    redirect("/")
