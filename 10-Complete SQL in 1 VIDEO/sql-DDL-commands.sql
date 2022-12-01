-- DDL data defination language commands :

-- # data base commands

-- show database 
show databases;

-- create database
create database if not exists learndb;

-- use database
use learndb;

-- rename database
-- RENAME DATABASE old_database_name TO new_database_name;  // this command is only work in oracle

-- drop database
drop database learndbms;

-- # table commands 

-- * show table 
show tables;

-- * create table 
create table students(
	id int(20),
    name varchar(20),
    address text,
    entryTimeStamp datetime
);

create table dpt(
	dpt_name varchar(20),
    dpt_code integer(10), 
    primary key(dpt_code)
);


-- * decribe table structure
desc students;

-- * rename table 
--          old name   new name
rename table students to emp;

-- * alter table (edit table)  :

-- Add
-- 		   tbname   colname constraints
alter table emp add mono int(10);

--         tbname                    multiple col add using ',' coma
alter table emp add (email varchar(30) unique, lname varchar(10));

alter table emp add (dpt_id integer);
--            add foreign key   emp.colname (child tb) dpt.colname (parents tb) 
alter table emp add foreign key (dpt_id) references dpt(dpt_code);
--             add check (condition)
alter table emp add check(mono <= 10);
--  add default key  colname  keyword   value     
alter table emp add gender char default "m" ;

-- modify column
--         tbname       colname  constraints to modify or add only add not remove 
alter table emp modify mono int(10) primary key;

alter table emp modify email varchar(20) unique;

-- add default on any existing column
alter table emp alter gender set default "m";

-- drop
			
    -- drop column
		--         tbname     colname
		alter table emp drop gender;

	-- drop constraint
	-- remove unique key from email column
			--         tbname          colname
			alter table emp drop index email;
            SHOW INDEX FROM emp; -- tbname
            --       index name  tbname
            DROP INDEX email_2 ON emp; 
	-- remove primary key from 
			--          tbname     
			alter table emp drop primary key;
	-- remove foreign key
			--        tbname                 colname
			alter table emp drop foreign key dpt_id;
            --        index name   tbname
			DROP INDEX dpt_id ON emp;
            SHOW VARIABLES LIKE 'FOREIGN_KEY%';
             SET FOREIGN_KEY_CHECKS = 0;
            SHOW CREATE table emp;
	-- remove check 
			--        tbname           colname
			alter table emp drop check mono;
	-- remove default
			--       tbname        colname
			alter table emp alter gender drop default;
	-- remove not null form column
		--         tbname    colname             
		alter table emp add status varchar(10) not null;
        -- remove null
			--         tbname    colname               null
			alter table emp modify status varchar(10) null;

-- change column (rename column name command)
-- alter table emp rename column status to mariage_status; -- this command is only work in oracle
--           tbname         oldcolname  newcolname                  
alter table emp change column status mariage_status varchar(10);

-- rename table using alter command
create table test(id int(10));
show tables;
--        tbname           newtbname
alter table test rename to test2; 

-- *drop table
--          tbname
drop table test2;

-- *turncate table
insert into test values(10),(20),(30);
select * from test;
delete from test;
--             tbname
truncate table test;

-- *copy command
-- with data 
--          newtbname             oldtbname
create table test3 as select * from test;

/*

Note also that new_table inherits ONLY the basic column definitions, 
null settings and default values of the original_table.
It does not inherit indexes and auto_increment definitions.

*/

-- with out data 
--          newtbname  oldtbname
create table test3 like test;
select * from test3;
drop table test3;

-- SQL TEMP TABLE

/*

Temporary tables can be created at run-time and can do all kinds of operations that a normal table can do. These temporary tables are created inside tempdb database.

There are two types of temp tables based on the behavior and scope.

Local Temp Variable
Global Temp Variable

*/
--                      tbname
create temporary table temp(
id int(10)
);

insert into temp values(10), (20);
select * from temp;

--                   tbname
drop temporary table temp;

SHOW TABLES FROM INFORMATION_SCHEMA LIKE 'INNODB_TEMP%';

-- working of on delete cascade and on delete null

show tables;
desc emp;

























