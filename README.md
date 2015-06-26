#firewad

Web admin tool for [Firebird SQL RDBMS](http://firebirdsql.org/).
 
![](https://github.com/ctengiz/firewad/blob/master/docs/screenshot.png)

##Features

* Full representation of database objects
* Code completion from database objects (right now only tables)

##Install

###Requirements

* python 3
* write permissions to installation / clone directory

```
git clone https://github.com/ctengiz/firewad.git
cd firewad
pip install -r requirements.txt
python app.py
```

Now browse to http://127.0.0.1:18022

**SECURITY WARNING : Code is not ready for public serve yet (as a www service, db passwords is stored as plaintext in dbconfig.ini and access
to website is not secured. Use it only from localhost right now**


## Brief Todos

- [x] Basic database metadata representation
 - [ ] Dependencies for functions, exceptions, sequences, domains
 - [ ] Better dependency displays
- [ ] DDL Operations
 - [ ] Table
  - [ ] Create table
  - [ ] Field modification
  - [ ] Constraint / index  
 - [ ] View
 - [ ] Trigger
 - [ ] Procedure
 - [ ] Sequence
 - [ ] UDF
 - [ ] Exceptions
- [ ] Database operations
 - [x] Database info
 - [ ] Database parameter updates (sweep interval, shutdown etc.)
 - [ ] MON$ based analysis
 - [ ] Create
 - [ ] Backup / restore
 - [ ] DDL export
 - [ ] Schema View
- [ ] Data Operations
 - [ ] Sql query
  - [ ] Code completion
 - [ ] Data edit / insert / delete
 - [ ] Execute procedure / fetch results
 - [ ] Recompute statistics
- [ ] User management
- [ ] Code documentation
- [ ] Usage documentation
- [ ] Use github's isssue tracker
- [ ] Prepare a roadmap
- [ ] Package for windows
 
 

