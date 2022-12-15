/*

Cursor is a pointer to a memory area called context area. This context area is a memory region inside the 
Process Global Area or PGA assigned to hold the information about the processing of a SELECT statement or 
DML Statement such as INSERT, DELETE, UPDATE or MERGE.


What is the Context Area?
Let’s dig a little deeper and see what the context area is?

The context area is a special memory region inside the Process Global Area or PGA which helps oracle
server in processing an SQL statement by holding the important information about that statement.

This information includes:

Rows returned by a query.
Number of rows processed by a query.
A pointer to the parsed query in the shared pool.

Using cursor you can control the context area as it is a pointer to the same.


Advantages of Cursors
There are two main advantages of a cursor:

Cursor is names thus you can reference it in your program whenever you want.
Cursor allows you to fetch and process rows returned by a SELECT statement by a row at a time.


 Types of cursors in oracle database:
There are two types of cursors in oracle database:

1.Implicit cursor

Implicit Cursors in Oracle Database
As the name suggests these are the cursors which are automatically created by the oracle
server every time an SQL DML statement is executed. User cannot control the behavior 
of these cursors. Oracle server creates an implicitcursor in the background for any PL/SQL
block which executes an SQL statement as long as an explicit cursor does not exist for that SQL statement.

Oracle server associates a cursor with every DML statement. Each of the Update & Delete statements has cursors
which are responsible to identify those set of rows that are affected by the operation. Also the implicit cursor 
fulfills the need of a place for an Insert statement to receive the data that is to be inserted into the database.


2.Explicit cursor

In contrast to implicit cursors, we have explicit cursors. Explicit cursors are user defined cursors which means 
user has to create these cursors for any statement which returns more than one row of data. Unlike implicit 
cursor user has full control of explicit cursor. An explicit cursor can be generated only by naming the cursor 
in the declaration section of the PL/SQL block.



Advantages of Explicit Cursor:
Since Explicit cursors are user defined hence they give you more programmatic control on your program.
Explicit cursors are more efficient as compared to implicit cursors as in latters case it is hard to track data errors.


Steps for creating an Explicit Cursor
To create an explicit cursor you need to follow 4 steps. These 4 steps are:

Declare
Open
Fetch
Close
In case of implicit cursors oracle server performs all these steps automatically for you.



Declaring a cursor means initializing a cursor into memory. You define explicit cursor in declaration 
section of your PL/SQL block and associate it with the SELECT statement.

Syntax
CURSOR cursor_name IS select_statement;


Open: How to Open a Database Cursor?
Whenever oracle server comes across an ‘Open Cursor’ Statement the following four steps take place automatically.

All the variables including bind variables in the WHERE clause of a SELECT statement are examined.
Based on the values of the variables, the active set is determined, and the PL/SQL engine executes the query for that cursor.
Variables are examined at cursor open time.
The PL/SQL engine identifies the active set of data.
The active set pointer sets to the first row.


Syntax
OPEN cursor_name;


Fetch: How to retrieve data from cursor?
The process of retrieving the data from the cursor is called fetching. Once the cursor is declared and opened then you can retrieve the data from it. Let’s see how.

Syntax
FETCH cursor_name INTO PL/SQL variable;
Or 
FETCH cursor_name INTO PL/SQL record;
What happens when you execute fetc


 Close: How To Close a Database Cursor?
Once you are done working with your cursor it’s advisable to close it. As soon as the server comes across the closing statement of a cursor it will relinquish all the resources associated with it.

Syntax
CLOSE cursor_name;


Cursor Attributes
Oracle provides four attributes which work in correlation with cursors. These attributes are:

%FOUND
%NOTFOUND
%ISOPEN
%ROWCOUNT



First three attributes ‘Found’, ‘NotFound’ and ‘IsOpen’ are Boolean attributes whereas the last one ‘RowCount’ is a numeric attribute.

Let’s quickly take a look at all these attributes.

%Found
Cursor attribute ‘Found’ is a Boolean attribute which returns TRUE if the previous FETCH command returned a row otherwise it returns FALSE.

%NotFound
‘Not Found’ cursor attribute is also a Boolean attribute which returns TRUE only when previous FETCH command of the cursor did
not return a row otherwise this attribute will return FALSE.

%IsOpen
Again ‘Is Open’ Cursor attribute is a Boolean attribute which you can use to check whether your cursor is open
or not. It returns TRUE if the cursor is open otherwise it returns FALSE.

%RowCount
Row count cursor attribute is a numeric attribute which means it returns a numeric value as a result
and that value will be the number of records fetched from a cursor at that point in time.

*/

-- Implicit cursor

declare 
    name emp.ename%type;
begin
    select ename into name from emp where empno = 4455;
    if sql%notfound then
        dbms_output.put_line('data not found');
    elsif sql%found then
        dbms_output.put_line('found');
        dbms_output.put_line('name : ' || name);
        dbms_output.put_line('count : ' ||  sql%rowcount);
    end if;
end;
/

select * from emp;

/


-- Explicit cursor
set serveroutput on;
/
declare 
    name varchar(20);
    cursor ck is
    select name from names where length(name)<5;
begin
    open ck;
    loop
        fetch ck into name;
        dbms_output.put_line(name);
        exit when ck%NOTFOUND;
    end loop;
    if ck%isopen then
        dbms_output.put_line('true');
    end if;
    close ck;
end;
/

select * from names;
/


-- Cursor Parameter


declare 
    salary number(20);
    cursor cp (val number) is
    select salary from emp where sal>val;
begin
    open cp(5000);
    loop
        fetch cp into salary;
        dbms_output.put_line(salary);
        exit when cp%NOTFOUND;
    end loop;
    close cp;
end;

/
select * from emp;
/

-- Cursor Parameter With Default Value

declare 
    name varchar(30);
    id number;
    cursor cpd (numofrec number := 1) is
    select distinct ename, sal from emp where  rownum <= numofrec;
begin
    open cpd(10);
    loop
        fetch cpd into name, id;
        dbms_output.put_line(name || ' ' || id);
        exit when cpd%NOTFOUND;
    end loop;
    close cpd;
end;
    
    
/

select * from emp;
/

-- Cursor FOR Loop

declare 
    cursor cpf is
    select ename, sal from emp where rownum <=5;
begin
    for cprow in cpf loop
        dbms_output.put_line(cprow.ename || ' ' || cprow.sal);
    end loop;
end;

/

-- Cursor For Loop With Parameterized

declare 
    cursor cpfp (lim number) is
    select ename, sal from emp where rownum <= lim;
begin
    for i in cpfp(5) loop
        dbms_output.put_line(i.ename || ' ' || i.sal);
    end loop;
end;

/

--  Table Based Record Datatype

declare 
    rowdata emp%ROWTYPE;
begin
    select * into rowdata from emp where ename = 'niraj';
    dbms_output.put_line(rowdata.ename || ' ' ||rowdata.sal);
    dbms_output.put_line(rowdata.hiredate);
end;
/
--  Cursor Based Record Datatype

declare 
    cursor cbr is
    select * from emp where ename = 'niraj';
    
    cbrdata cbr%ROWTYPE;
begin

    open cbr;
    fetch cbr into cbrdata;
    dbms_output.put_line(cbrdata.ename || ' ' || cbrdata.sal);
    close cbr;
end;
/
set serverout on;
/


-- Cursor Based Record Datatype using loop

declare 
    cursor cbrf is 
    select * from emp;
    
    cbrfdata cbrf%ROWTYPE;
begin
    
    open cbrf;
    loop
        fetch cbrf into cbrfdata;
        dbms_output.put_line(cbrfdata.ename || ' ' || cbrfdata.sal);
        exit when cbrf%rowcount=5;
    end loop;

end;

/

-- User Defined Record Datatype


declare 
    
    type deptemp is record
    (
        deptno dept.deptno%TYPE,
        dname varchar(20),
        ename emp.ename%TYPE,
        empno emp.empno%TYPE
    );
    
    
    alldata deptemp;
begin

          select a.deptno, a.dname, b.empno, b.ename into alldata.deptno, alldata.dname, alldata.empno, alldata.ename
          from dept a inner join emp b on a.deptno = b.deptno where b.ename = 'niraj';
          dbms_output.put_line(alldata.deptno || ' ' || alldata.dname|| ' ' || alldata.ename || ' ' || alldata.empno);

end;

/
select * from emp;
select * from dept;
/
select a.deptno, a.dname, b.empno, b.ename, b.job, b.sal from dept a inner join emp b on a.deptno = b.deptno;
/
select deptno, ename from dept a join emp b using(deptno) where ename = 'niraj';
/

select a.deptno, b.ename from dept a inner join emp b on a.deptno=b.deptno;


-- practice

/
declare

   
    
    cursor empcur is
        select * from emp where deptno = 30;
        
     empdetails empcur%rowtype;
begin
    open empcur;
    loop 
        fetch empcur into empdetails;
        dbms_output.put_line('empno = ' || empdetails.empno);
        dbms_output.put_line('empname = ' || empdetails.ename);
        exit when empcur%notfound;
    end loop;
    close empcur;
end;



/
select * from emp;


/

declare

    cursor empcur is
    select ename, job from emp where job = 'SALESMAN' or job='CLERK';


begin

    for i in empcur loop
        dbms_output.put_line(i.ename ||' '|| i.job);
    end loop;

end;

/

declare

    cursor empcur is
    select ename, job from emp where ename='niraj';


begin

    for i in empcur loop
        dbms_output.put_line(i.ename ||' '|| i.job);
    end loop;

end;

/
declare

    cursor empcur is
    select ename, job from emp where job = 'SALESMAN' or job='CLERK';


begin

    for i in empcur loop
        dbms_output.put_line(i.ename ||' '|| i.job);
    end loop;

end;
/

declare

cursor empcur is
select sal, empno from emp where deptno = 30; 

begin

for i in empcur loop

dbms_output.put_line(((i.sal*15/100)+i.sal) ||' '||i.empno);

update emp set sal = ((i.sal*15/100)+i.sal) where empno = i.empno;

end loop;

end;
/

select sysdate from dual;