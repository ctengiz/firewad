#firewad

Web admin tool for [Firebird SQL RDBMS](http://firebirdsql.org/).
 
![](https://github.com/ctengiz/firewad/blob/master/docs/screenshot.png)

##Features 

- [ ] Full database metadata representation
 - [x] Tables
 - [x] Views
 - [x] Trigger
 - [x] Procedure
 - [x] Sequence
 - [x] UDF
 - [x] Exceptions
 - [ ] Better dependency displays (also dependency display for UDF, sequence, domain, exception)
- [ ] Database operations
 - [ ] Create Database
 - [ ] Drop Database
 - [x] Database info via isc_info calls
 - [ ] Database parameter updates (sweep interval, shutdown etc.)
 - [ ] MON$ based analysis
 - [ ] Backup / restore
 - [ ] DDL export
 - [ ] Schema View
- [ ] DDL Operations
 - [ ] Table
  - [ ] Create table
  - [ ] Field modification
  - [ ] Constraint / index  
  - [ ] Select * from table
 - [ ] View
 - [ ] Trigger
 - [ ] Procedure
 - [ ] Sequence
 - [ ] UDF
 - [ ] Exceptions
- [ ] Data Operations
 - [x] Sql query
  - [ ] Code completion (semi supported)
  - [x] Execution plan
  - [x] Param support
  - [ ] Save & Load query sqls
 - [ ] Data edit / insert / delete
 - [ ] Execute procedure / fetch results
 - [ ] Recompute statistics
- [ ] Script execution support
- [ ] User management


##Install

###Requirements

* Firebird 2.1+ (though only tested with 2.5, but all major sholuld be fine with 2.1)
* python 3+
* write permissions to directory where the firewad is installed

```
git clone https://github.com/ctengiz/firewad.git
cd firewad
pip install -r requirements.txt
python app.py
```

Now browse to http://127.0.0.1:18022

**SECURITY WARNING : Code is not ready for public serve yet (as a www service), db passwords is stored as plaintext in dbconfig.ini and access
to website is not secured. Use it only from localhost right now**


## Todos

- [ ] Code documentation
- [ ] Usage documentation
- [ ] Use github's isssue tracker
- [ ] Prepare a roadmap
- [ ] Package for windows



 
 

