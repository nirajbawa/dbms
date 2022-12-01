/*

using instead of triggers you can control the default behaviour of insert,
update, delete and merge operations on views but not on tables.

use of instead of triggers 

-we can use then to make a non updatable view updatable.

- override the default behavior of view that are updatable.


syntax:


create [or replace] triggers tname
instead of operation
on viewname
for each row
begin

end;


*/

desc names;
desc test1;
/
create table names(
    name varchar(20)
);
/


-- normal view
-- in normal single table view without join operation we have feature to perform dml operations on view


create or replace view t3
as 
select * from test1;
/
select * from t3;
/
insert into t3 values(33);
update t3 set id= 34 where id =123;
delete from t3 where id = 34;
/

-- join view
-- in join view we not have option do perform dml operation on view
create or replace view t2 
as 
select test1.*, names.* from test1, names;
/
select * from t2;
/
insert into t2 values(44,'hff');
update t2 set name = 'niraj', id = 12 where id = 3;
delete from t2 where id = 3;
/

drop view t2;
/
insert into names values('rrrrrrrrrr');
insert into test1 values(3);
truncate table names;
select * from test1;
/
-- for solving above problem we use instead of tiggers

-- instead of trigger for insert
/

create or replace trigger insertinstead
instead of insert on t2
for each row
begin
    insert into test1 values(:new.id);
    insert into names values(:new.name);
end;
/

insert into t2 values(100,'sfsds');
select * from t2;
/

-- update instead of tigger

create or replace trigger updateinstead
instead of update on t2
for each row
begin

update names set name = :new.name where name = :old.name;
update test1 set id = :old.id where id = :old.id;

end;

/
update t2 set name = 'niraj', id = 13 where id = 12;
select * from t2;


/

-- delete instead of tigger

create or replace trigger updateinstead
instead of delete on t2
for each row
begin

delete from test1 where id = :old.id;
delete from names where name= :old.name;

end;

/
delete from t2 where id = 12;
/
select * from t2;


select table_name from user_tables;

 