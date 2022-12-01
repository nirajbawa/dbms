-- database event triggers come into action when system event occurs 
-- such as 

/*

1.database log on
2.log off
3.start up or
4.shut down

database event triggers can be created to monitor the system event activites of either a specific

1. user or
2. a whole database

any usert of your database can create a database event trigger in it own schema if it has
create triggers system privilege

to create a trigger on the datbase you must need administrative database trigger system privileges.


*/


-- Create Database Event 'LogOn' Trigger


create table systemaudit(
    u_name varchar(20),
    logintimestamp timestamp,
    logouttimetamp timestamp,
    eventname varchar(20)
);
/
create or replace trigger logonevent
after logon on schema 
declare 
    u_name varchar(20);
begin
    select user into u_name from dual;
    insert into systemaudit values(
    u_name,
    sysdate,
    null,
    ora_sysevent
    );
end;
/

select  * from systemaudit;
/

--Database Event 'Log Off' Trigger

-- only for schema

create or replace trigger logoffevent
before logoff on schema
declare 
    u_name varchar(20);
begin
    select user into u_name from dual;
    insert into systemaudit values(
    u_name,
    null,
    sysdate,
    ora_sysevent
    );
end;
/
disc;
conn system/niraj;
/

-- logoff auditing for all db users

create table sysactivityaudit(
    u_name varchar(20),
    logintimestamp timestamp,
    logouttimetamp timestamp,
    eventname varchar(20)
);
/

create or replace trigger logofaudit
before logoff on database
declare
    u_name varchar(20);
begin
     select user into u_name from dual;
    insert into sysactivityaudit values(
    u_name,
    null,
    sysdate,
    ora_sysevent
    );
end;
/

select  * from sysactivityaudit;

disc;
conn system/niraj;
conn niraj/niraj;
/
-- How To Create Startup Trigger 

create table startupeve(
    logintimestamp timestamp,
    eventname varchar(20)
);
/
create or replace trigger startuponevents
after startup on database
begin
    insert into startupeve values(
    sysdate,
    ora_sysevent
    );
end;
/
select  * from startupeve;

