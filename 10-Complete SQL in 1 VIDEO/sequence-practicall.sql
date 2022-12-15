-- sequence

create sequence myint
start with 1
increment by 1
minvalue 1
maxvalue 100
cycle;

alter sequence myint nocycle nocache;

select * from test1;
truncate table test1;

insert into test1 values(myint.nextval);

-- synonym

conn system/niraj as sysdba;

create user hra identified by hrapass;

conn hra/hrapass;


select table_name from user_tables;
select * from dept;

insert into dept values(1,'development', 'india');

conn niraj/niraj;

grant select on dept to hra;
