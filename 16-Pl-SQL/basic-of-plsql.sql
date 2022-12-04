-- pl/ sql full form is procedural language extension of structure query language

-- http://www.rebellionrider.com/category/pl-sql/

set serveroutput on;

-- basic anonymous structure variable declaration and output statement

declare 
    num number(6);
    name varchar2(20);
begin 
    num := 65;
    name := 'niraj';
    dbms_output.put_line(num);
    dbms_output.put_line(name);
end;
/


-- basic single column select query 

declare 
    empno number(20);
    ename varchar2(30);
begin
    select empno, ename into empno, ename from emp where empno = 7839;
    dbms_output.put_line('name : '||ename|| ' emp no : '||empno);
end;
/

-- basic input statement
declare 
    emp number(20);
begin
    emp := &emp;
    dbms_output.put_line(emp);
end;

/
-- Anchored Datatype (%TYPE)
declare 
    name emp.ename%type;
    eno emp.empno%type;
begin
    select empno, ename into eno, name from emp where empno = 7839;
    dbms_output.put_line('eno : '||eno||' name : '||name);
end;
    
/
-- Constants 

declare 
    num constant number(20) := 20;
begin 
    dbms_output.put_line(num);
end;
/
-- Constants using default and not null

declare 
    num constant number(20) not null default 20;
begin 
    dbms_output.put_line(num);
end;
/
-- Bind Variable 
-- print automatically after define variable
set autoprint on;
variable name varchar2(20);
exec :name := 'niraj';


variable n number;

begin
    :n := 20;
    dbms_output.put_line(:n);
end;


variable new number;
exec :new := 24;

print :new;



    

SELECT table_name FROM user_tables;
select * from emp;