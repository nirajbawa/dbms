
/*
In Oracle Database we can define a PL/SQL function as a self-contained sub-program that is meant to do some specific well defined task.
Functions are named PL/SQL block which means they can be stored into the database as a database object and can be reused.
That is also the reason why some books refer to PL/SQL functions as stored functions.



Types of PL/SQL functions in Oracle Database
There are two types of PL/SQL functions in Oracle Database, these are

Pass-by-Value Functions and
Pass-by-Reference functions
In Oracle Database both types of functions should have to return some values and these values should be a valid SQL or PL/SQL datatype.

Pass-by-Value Functions and
Pass-by-Reference functions
In Oracle Database both types of functions should have to return some values and these values should be a valid SQL or PL/SQL datatype.


Function Execution Method
Depending on your creativity and programming skills, a PL/SQL function can be called by multiple ways. Here are some general ways of calling a PL/SQL function in Oracle Database

You can use SQL*Plus utility of the Oracle Database to invoke a PL/SQL function that can be called from PL/SQL as procedural statement.
An anonymous PL/SQL block can also be used to call a function.
You can even call a function directly into a SELECT or DML statement.

Restrictions on calling a function
A function that returns SQL datatype can be used inside SQL statement and a PL/SQL function that returns PL/SQL datatype only works inside PL/SQL blocks.
An exception to this rule is that, you cannot call a function that contains a DML operation inside a SQL query. However you can call a function that performs a 
DML operation inside INSERT, UPDATE and DELETE.
A function called from an UPDATE or DELETE statement on a table cannot query (SELECT) or perform transaction (DMLs) on the same table.
A function called from SQL expressions cannot contain the TCL (COMMIT or ROLLBACK) command or the DDL (CREATE or ALTER) command


*/



-- functions with parameter
create or replace function area_of_circle (radius number)
return number is
    pi constant number(20, 2) := 3.14;
    area number(7);
begin
    area := pi + (radius*radius);
    return area;
end;
/


declare 
    out number(20,5);
begin
    out := area_of_circle(2);
    dbms_output.put_line(out);

end;
/


-- functions without parameter
create or replace function area_of_circle_without_params
return number is
    pi constant number(20, 2) := 3.14;
    area number(7);
    radius number :=20;
begin
    area := pi * (radius*radius);
    return area;
end;
/


declare 
    out number(20,5);
begin
    out := area_of_circle_without_params();
    dbms_output.put_line(out);

end;
/

-- Calling Notation for PL/SQL Subroutines

create or replace function notations(v1 number, v2 number, v3 number)
return number is
    
begin
    dbms_output.put_line('var 1 : '||v1);
    dbms_output.put_line('var 2 : '||v2);
    dbms_output.put_line('var 3 : '||v3);
    return v1+v2+v3;
end;

/


set serveroutput on;
/

declare

total number;

begin

total := notations(v1 => 5, v2=>5, v3=>10);
dbms_output.put_line('total = '||total);

end;



