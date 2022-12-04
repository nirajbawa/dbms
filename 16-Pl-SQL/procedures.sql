/*

Similar to PL/SQL Functions a stored Procedure is a self-contained subprogram that is meant to do some specific tasks.
Also similar to functions, procedures are named PL/SQL blocks thus they can be reused because they are stored into the 
database as a database object. But unlike PL/SQL functions a stored procedure does not return any value. 


Syntax of PL/SQL Stored Procedures
CREATE [OR REPLACE] PROCEDURE pro_name (Parameter – List)
IS [AUTHID 	DEFINER | CURRENT_USER]
	Declare statements
BEGIN
	Executable statements 
END procedure name;
/ 
The above Syntax of PL/SQL stored procedure is pretty much similar to the syntax of PL/SQL Functions that we saw in the last PL/SQL tutorial.  Except for two things:

There is no Return clause.
A core difference between a PL/SQL Function and a stored procedure is that unlike Functions a stored procedure does not return any value.


AUTHID Clause.
The AUTHID clause is used for setting the authority model for the PL/SQL Procedures. This clause has two flags.

DEFINER and
CURRENT_USER
As this clause is optional thus in case if you do not use AUTHID clause then Oracle Engine will set the authority (AUTHID) to the DEFINER by default for you. Now, you must be wondering what these DEFINER and CURRENT_USER rights are?

DEFINER right: Definer right is the default right assigned to the procedure by oracle engine. This right means anyone with Execution Privilege on the procedure acts as if they are the owner of the schema in which the privilege is created.   

CURRENT_USER right: Setting the authority level of a stored procedure to the current_user right overrides the default right which is definer and change it to the invoker rights.

Invoker right authority means that you call the procedure to act on your local data and it requires that you replicate data objects in any participating schema.



Some Extra Points About Stored Procedure
You can define a procedure with or without formal parameters.
A parameter can be either pass-by-value or pass-by-reference.
A procedure will be a pass-by-value procedure when you don’t specify the parameter mode because it uses the default IN mode.





*/


-- procedure with argument 
create or replace procedure area_circle(r number)
is
    pi number := 3.14;
    area number;
begin
    area := pi*(r*r);
    dbms_output.put_line('area = '||area);
end area_circle;
/

execute area_circle(20);

/

begin
    area_circle(32);
end;
/

-- procedure without argument 
create or replace procedure area_circle_S
is
    pi number := 3.14;
    area number;
    r number := 20;
begin
    area := pi*(r*r);
    dbms_output.put_line('area = '||area);
end;

/


exec area_circle_S;


desc emp;
select * from emp;

-- create employee select sal 
/

create or replace procedure select_sal_wise (eno number) is

empdata emp%ROWTYPE;

begin
     select * into empdata from emp where empno = eno;
    dbms_output.put_line(empdata.empno ||' ' || empdata.sal||' '||empdata.ename);
end;

/

 select empno, ename, sal from emp where empno = 4455;
/

exec select_sal_wise(4455);
/


