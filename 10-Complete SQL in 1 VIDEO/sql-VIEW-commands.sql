-- sql view

/*

Views in SQL are considered as a virtual table. A view also contains rows and columns.

To create the view, we can select the fields from one or more tables present in the database.

A view can either have specific rows based on certain condition or all the rows of a table.

*/

use learndb;

-- #create view 

create view userDis as
select uname from users;


-- #selecting from view
select * from userdis;


-- #alter view

alter view userdis as
select * from udescriptions;

select * from userdis;

-- #view with mulitple tables join

alter view userdis as 
select a.uname, a.uemail, b.ufname, b.ulname, b.ubio from users as a
inner join udescriptions as b on b.uemail=a.uemail;


select * from userdis;

-- # view with subquery

create or replace view userdis 
as select a.* from (select ubio from udescriptions where length(ubio) > 5) as a;

-- #when apply any dml command on view it refelect of real table
insert into userdis values ('raj232@gmail.com', 'jar','marathe',1,'', '');
update userdis set ufname = 'raj' where ufname = 'jar';
delete from userdis where ufname = 'raj';

-- #with check option
-- alter
create or replace view userdis 
as 
select * from udescriptions where ubio = 'nothing'
WITH CHECK OPTION;

insert into userdis values ('raj232@gmail.com', 'jar','marathe',1,'nothing', '');

-- rename view table
rename table usedis to userdis;

-- drop view

drop view userdis;





show tables;
select * from users;
select * from udescriptions;
desc users;