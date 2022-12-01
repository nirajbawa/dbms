-- # SEQUENCE in sql

-- # identity is defualt
create table n(
	a int primary key auto_increment
);

drop table n;

-- #SEQUENCE
-- sequence is not work in mysql but work in oracle and others
/*

-- # create sequence

create sequence myinc
start with 1
increment by 1
minvalue 1
maxvalue 1000
cycle 

-- # alter sequence 

alter sequence myinc minvalue 1;

-- # drop sequence

drop sequence myinc;



--(also add 'no cycle')

insert into n values (next value for myinc);

*/

