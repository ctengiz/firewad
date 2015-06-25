#firewad

Web admin tool for [Firebird SQL RDBMS](http://firebirdsql.org/).
 
![](https://github.com/ctengiz/firewad/blob/master/docs/screenshot.png)

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


## Basic Todo List

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
 - [ ] Database info
 - [ ] Create
 - [ ] Backup / restore
 - [ ] DDL export
- [ ] Data Operations
 - [ ] Sql query
 - [ ] Data edit / insert / delete
 - [ ] Execute procedure / fetch results
 - [ ] Recompute statistics
- [ ] User management
- [ ] Code documentation
- [ ] Usage documentation

 
 

