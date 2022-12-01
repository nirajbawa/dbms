-- data manipulation language
-- SQL INSERT statement is a SQL query. It is used to insert a single or a multiple records in a table.
-- There are two ways to insert data in a table:
/*

1. By SQL insert into statement
	1.By specifying column names
	2.Without specifying column names
2. By SQL insert into select statement

*/

use learndb;

create table dml_customers(
	id integer primary key auto_increment,
    name varchar(20) not null,
    mono varchar(10) unique,
    email varchar(50)
);

create table dml_customers_order_com(
	custid integer,
    custname varchar(20),
    custmono varchar(10)
);


drop table dml_customers;


-- # insert into 
	
-- *single insert with all values with default secquence
--            tbname                  value table default secquence wise
insert into dml_customers values(null, 'nirjaj', 939874379541, 'nirajbava222@gmail.com');

-- *single insert with values with custom secquence
--            tbname            colnames                            value custom sequence wise
insert into dml_customers (name, email, mono) values('rampal ji maharaj', 'satlokaashram11@gmail.com', 1234567891);

-- * multiple insert in single command
--            tbname               colnames                     value custom sequence wise  ',' to next insert
insert into dml_customers (id,name, mono, email) values (null, "a", 123456585, 'a1@gmail.com'), (null, "b", 123456783, "b2@gmail.com"),
(null, "c", 123456745, 'c3@gmail.com');

-- * multiple insert in single command with default secquence
--            tbname                          value default sequence wise  ',' to next insert
insert into dml_customers  values (null, "a", 123456585, 'a1@gmail.com'), (null, "b", 123456783, "b2@gmail.com"),
(null, "c", 123456745, 'c3@gmail.com');



-- *Inserting data through SELECT Statement
--            tbname                   colnames                select values form another table 
insert into dml_customers_order_com (custid, custname, custmono) select id, name, mono from dml_customers;
insert into dml_customers_order_com  select id, name, mono from dml_customers;


-- # update commands :

-- sql update all columns 
--         tbname
update dml_customers
set email = 'none'; -- column name = value

-- sql update specific column

update dml_customers -- tbname
set email = "nirajbava222@gmail.com" -- column name = value
where id = '2'; -- condition

-- sql update specific multiple fields of column

update dml_customers -- tbname
set email = "niraj bava", mono = 9359839551 -- colname = values , colname = value
where id = 2; -- conditions


-- sql update using select from another table using join with realation
--      tbname          use as
update dml_customers as tb1 
--           inner join to tbname   use as
inner join dml_customers_order_com as tb2
on tb1.id=tb2.custid  -- condtion for selecting rows
set mono = tb2.custmono -- set value colname = value
where  tb1.id = 31; -- condition for in which row to update


-- sql update date YYYY-MM-DD HH:MM:SS:

update dpt
set e_time_stamp = '2023-12-30 01:50:22'
where dpt_code = 102;

 -- # delete commands :
 
 -- delete specific row
 --            tbname             condition to where update row
 delete from dml_customers where id = 7;
 
 -- delete all rows from table
 --             tbname
 delete from dml_customers;
 
 -- delete from another table using join with relation
 --  trageted tbanem where data is delete
 delete t1,t2  from dml_customers as t1 -- tbname as use
 inner join dml_customers_order_com as t2 -- tbname as use
 on t2.custid=t1.id -- condtion for relation
 where t1.id = 10; -- condtion for which row to delete
 
 -- delete the duplicate row from
 --    trageted tbname tbname use as
 delete t1 from dml_customers as t1
 inner join dml_customers as t2 -- tbanem use as
 where t1.id<t2.id and t1.name=t2.name; -- condition

-- # delete all the child records of row after deleting parent row in parent table using on delete cascade and null

create table users(
uname varchar(20) unique not null,
uemail varchar(30) primary key,
upassword varchar(200) not null
);

-- on delete cascade 
create table udescriptions(
uemail varchar(30) primary key,
ufname varchar(20) not null,
ulname varchar(20) not null,
uactype boolean default 0,
ubio tinytext null,
foreign key (uemail) references users(uemail) on delete cascade
);

-- on delete null
create table udescriptions(
uemail varchar(30) primary key,
ufname varchar(20) not null,
ulname varchar(20) not null,
uactype boolean default 0,
ubio tinytext null,
foreign key (uemail) references users(uemail) on delete cascade on update cascade
);


insert into users values ('nirajbava111', 'nirajbava222@gmail.com', 'niraj@#&123'), ('raj@131', 'raj232@gmail.com', 'raj@#&123'), ('sonu@131', 'sonu@gmail.com', 'sonu@#23'), ('ramu@131', 'ramu55@gmail.com', 'ramu@#4423'), ('rahul@131', 'rahul458@gmail.com', 'rahul@#4423');

insert into udescriptions values ('nirajbava222@gmail.com', 'niraj', 'bava', 1, 'code-eate-code-sleep'), ('raj232@gmail.com', 'raj', 'bagul', 0, ''), ('ramu55@gmail.com', 'ramu', 'marathe', 0, 'life is journey enjoy it'), ('sonu@gmail.com', 'sonu', 'sharma', 1, 'at office'), ('rahul458@gmail.com', 'rahul', 'singh', 0, 'never give up');

-- delete row form parents table so related child table row also delete 

delete from users where uemail = "raj232@gmail.com";

-- update rows in parent and also update match rows from child table

update users 
set uemail = "nirajbava333@gmail.com"
where uemail = "nirajbava222@gmail.com"; 

drop table udescriptions;

select * from users;
select * from udescriptions;
truncate table users;
show tables;
desc users;
desc udescriptions;


 
 -- # replace
 -- if codition not match parameter exit so it insert into new row 
 -- else codition match parameter so it update another of rows
 --            tbname            column names                    values                
 replace into dml_customers(id,name, mono, email) values (30, "a", 123456585, 'a1@gmail.com');
 
 replace into dml_customers -- tbname
 --  columns to relpace and values col = value 
 set id = 30,  name = 'none'; -- matching id and paramerter if not exitst insert else update
 
 -- replace using another table
 
 replace into dml_customers(id,name, mono) select 30, custname, custmono from dml_customers_order_com where custid = 20 ;
 
 update dml_customers_order_com set custid = 20, custname = 'this' where custid=30;



select * from dml_customers;
select * from dml_customers_order_com;
truncate table dml_customers_order_com;
show tables;
desc dml_customers_order_com;
desc dpt;

