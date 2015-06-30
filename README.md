#firewad

Web admin tool for [Firebird SQL RDBMS](http://firebirdsql.org/).

I love Firebird and I use it since InterBase was open-sourced (sooo long ago !). When I also began to use MacOSX
for development two years ago I've missed tools I've used to use such as [IBExpert](http://www.ibexpert.net/ibe/). 
So this project is born.

Main Goals are :

- Be platform independent, easily deployed
- A helper for database monitoring and performance tuning 
- Adhoc queries for simple reports, data inspection
- Easy database maintanence and administration operations
- Provide a platform for database schema migration for my own projects
 
![](https://github.com/ctengiz/firewad/blob/master/docs/screenshot.png)
![](https://github.com/ctengiz/firewad/blob/master/docs/screenshot-01.png)
![](https://github.com/ctengiz/firewad/blob/master/docs/screenshot-02.png)

##Features 

The list below, is a mix of features completed and features which are planned to be implemented. Yet this is not
 a full plan list. It grows while I play with the project. Any suggestions are welcome.

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
   - [ ] Drop table
   - [ ] Field modification
   - [ ] Alter / Create constraints / indices  
   - [x] Quick query from table (select * from ..)
 - [ ] View
   - [ ] Create view
   - [ ] Drop view
   - [ ] Alter view
   - [x] Quick query from view (select * from ..)
   - [ ] Create view from query
 - [ ] Trigger
 - [ ] Procedure
   - [x] Quick query from procedure (select * from ..)
   - [x] Quick execution of procedure
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

**SECURITY WARNING : Code is not ready for public serve yet (as a www service), db passwords is stored as plaintext in 
dbconfig.ini and access to website is not secured. Use it only from localhost right now**


## Todos

- [ ] Code documentation
- [ ] Usage documentation
- [ ] Use github's isssue tracker
- [ ] Prepare a roadmap
- [ ] Package for windows



 
 

