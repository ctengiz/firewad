""" 
Script parse playground
"""

import re

script = """
create table a1 (
aa varcahr(20)
bb bigint);

create index ndx_a1 on a1(aa);
create index ndx_b1 on a1(bb);

create trigger tr_a1_bi
before insert
as
declare variable xx integer;
begin
  xx = 1;
end;

create procedure p1(x1 integer)
returns (x2 integer)
as
begin
  x2 = x1;
  x1 = x2;
  x2 = 2*4;
  begin

  end
end;

execute block as
begin

end
;

execute block as begin end;

create trigger tr_a as begin end;

create table a1 (
aa varcahr(20)
bb bigint);

create index ndx_a1 on a1(aa);
create index ndx_b1 on a1(bb);

/*
block comment
*/

/* klklklk */


/**************************************
***
***************************************/

create trigger tr_a1_bi
before insert
as
declare variable xx integer;
begin
  xx = 1;
end;

--last line

create procedure p1(x1 integer)
returns (x2 integer)
as
begin
  x2 = x1;
  x1 = x2;
  x2 = 2*4;
  begin

  end
end
;


--last line
"""

script = """
-- todo: task yönetimi için de bir tablo olmalı. --> Bu tablo
-- ayrıca bu tablo import ve export edilebilinmeli

insert into app(idx, code, title, admin_required, login_required, maintanence_mode)
  values (next value for seq_app, 'admin', 'System Administration', 1, 1, 0);

insert into app(idx, code, title, admin_required, login_required, maintanence_mode)
  values (next value for seq_app, 'system', 'System Functions', 0, 0, 0);

insert into app(idx, code, title, admin_required, login_required, maintanence_mode)
  values (next value for seq_app, 'invigo', 'Invigo ERP', 0, 0, 0);

insert into app(idx, code, title, admin_required, login_required, maintanence_mode)
  values (next value for seq_app, 'wiki', 'Wiki', 0, 0, 0);


"""

p = re.compile(r"(execute(\s)block|create(\s)+(procedure|trigger))(?s).*?(.*?)end(\s*);", re.IGNORECASE)
block_num = 0
blocks = []
iterator = p.finditer(script)
for match in iterator:
    blocks.append(match.group())
    block_text = ';__block:%d;' % block_num
    script = script.replace(match.group(), block_text, 1)
    block_num += 1

#replace block comments
p = re.compile(r"/\*(?s).*?\*/")
script = p.sub("", script)

sqls = []
lines = script.split(';')
for ndx, ln in enumerate(lines):
    ln = ln.strip()
    if ln[0:7] == '__block':
        block_num = int(ln.split(':')[1])
        sql = blocks[int(ln.split(':')[1])]
    elif ln[0:2] == '--':
        for _new_ln in reversed(ln.splitlines()[1:]):
            _new_ln = _new_ln.strip()
            if _new_ln:
                lines.insert(ndx + 1, _new_ln)
        sql = None
    else:
        sql = ln

    if sql:
        sqls.append(sql)

for sql in sqls:
    print(sql)