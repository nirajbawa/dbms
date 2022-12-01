-- #trigers in pl/sql

-- triggers are specialized store program which are execute implicitly when triggering a event occurs

-- type of events

/*

1. a dml statement 
2. a ddl staement
3. a system event
4. a user event

*/

-- type of tirggers

/*

1. dml triggers

2. ddl triggers

3. system/database event triggers

4. instead of triggers 

5. compound triggers

-- syntax of trigger

create [or replace] trigger trigger_name 
{before | after} trigger_event on table_name
[for each row] [follows another_trigger_name]
[enable/disable] [when condition]
declare
    declaration  statement
begin 
    executable statement
end;

uses

1.enforce business rules
2.gain strong control over the security
2.collect statical information
3.automatically generate values;
*/


create table test1(
    id varchar(20)
);
/


-- 1. dml triggers

create or replace trigger custri
before insert on test1 
for each row
enable
declare
    cust_user_name varchar2(20);
begin
    select user into cust_user_name from dual;
    dbms_output.put_line(cust_user_name||' you exeute insert command');
end;
/

insert into test1 values('1');

/

create or replace trigger CUST_TRI
before insert or update or delete on emp 
for each row
disable
declare
    cust_user_name varchar2(20);
begin
    select user into cust_user_name from dual;
    if inserting then
        dbms_output.put_line(cust_user_name||' * you exeute insert command');
    elsif updating then
        dbms_output.put_line(cust_user_name||' you exeute update command');
    elsif deleting then 
        dbms_output.put_line(cust_user_name||' you exeute delete command');
    else 
        dbms_output.put_line('you exeute command');
    end if;
end;
/

insert into test1 values('1');
update test1 set id = '2' where id = '1';
delete from test1 where id='2';
/

-- auditing table using trigger 

create table auditemp(
    new_name varchar(20),
    old_name varchar(20),
    tstamp timestamp,
    uname varchar(20),
    c_name varchar(20)
);

create or replace trigger triforemp 
before insert or update or delete on emp
for each row
disable
declare 
    n_name varchar2(20);
begin 
    select user into n_name from dual;
    if inserting then 
        insert into auditemp values(:new.ename, null, current_timestamp, n_name, 'insert');
        dbms_output.put_line('insering a element');
    elsif deleting then
        insert into auditemp values(null, :old.ename, current_timestamp,n_name, 'delete');
        dbms_output.put_line('deleting a element');
    elsif updating then
        insert into auditemp values(:new.ename, :old.ename, current_timestamp,n_name, 'update');
        dbms_output.put_line('updating a element');
    end if;
end;
/

insert into emp values (7736,'raman', 'MANAGER', 7839, sysdate, 5000, 7839, 10);
update emp set ename = 'rampalji' where ename = 'raman'; 
delete from emp where ename = 'rampalji';

select * from emp;

select * from auditemp;
truncate table auditemp;

select CURRENT_TIMESTAMP from dual;
/

-- Make synchronized backup copy of a table

create table empcopy as select * from emp where 1=2;


create or replace trigger empcopyondml
before insert or delete or update on emp
for each row
enable
declare
    u_name varchar(20);
begin
    select user into u_name from dual;
    
    if inserting then 
        insert into empcopy values(:new.empno, :new.ename,  :new.job, :new.mgr, :new.hiredate, :new.sal, :new.comm, :new.deptno);
        dbms_output.put_line('inserting');
    elsif deleting then
        delete from empcopy where empno = :old.empno  or ename= :old.ename or job = :old.job or  mgr= :old.mgr or hiredate = :old.hiredate or sal= :old.sal or comm = :old.comm or deptno= :old.deptno;
    elsif updating then
        update empcopy set empno = :new.empno, ename= :new.ename, job = :new.job,  mgr= :new.mgr, hiredate = :new.hiredate, sal= :new.sal, comm = :new.comm, deptno= :new.deptno;
    end if;
end;
/

insert into emp values (7724,'ram5435an', 'MANAGER', 7839, sysdate, 5000, 7839, 20);
delete from emp where deptno = 20;
update emp set empno = 4455, ename = 'niraj' where empno = 7724;

select * from emp;
select * from empcopy;













