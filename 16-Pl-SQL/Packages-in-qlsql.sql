/*

-What are PL/SQL Packages in Oracle Database?

Packages are stored libraries in the database which allow us to group related PL/SQL objects under one name. 
Or in simple words, Packages are logical groups of related PL/SQL objects. Packages are named PL/SQL 
Blocks which mean they are permanently stored into the database schema and can be referenced or reused by your program.


-Definition of PL/SQL Packages

Packages are stored libraries in the database which allow us to group related PL/SQL objects under one name.

-What are the contents included in a package?

A package can hold multiple database objects such as

Stored Procedures

PL/SQL Functions

Database Cursors

Type declarations as well as

Variables

- Info Byte
All the objects included into a package are collectively called Package Elements.

Package Architecture
PL/SQL package is divided into two parts:

The Package Specification, also known as the Header and
The Package Body
Both these parts are stored separately in the data dictionary. The package specification is the required part whereas the package body is optional, but it is a good practice to provide the body to the package.


Package Architecture
PL/SQL package is divided into two parts:

-The Package Specification, also known as the Header and

-The Package Body

Both these parts are stored separately in the data dictionary. The package specification is the required part whereas the package
body is optional, but it is a good practice to provide the body to the package.

-Syntax of Package specification
CREATE OR REPALCE PACKAGE pkg_name IS
	Declaration of all the package element…;
END [pkg_name]; 


-Syntax of the package body
CREATE OR REPALCE PACKAGE BODY pkg_name IS
	Variable declaration;
	Type Declaration;
BEGIN
	Implementation of the package elements…
END [pkg_name];

-- reference 
http://www.rebellionrider.com/introduction-to-pl-sql-packages-in-oracle-database/#.WIYwa_l97IU
*/


-- Create PL/SQL Package header or specification

set serverout on;

/

create or replace package pk_first is
    function print_string return varchar2;
    procedure findrec (fname varchar2, pass varchar2);
end pk_first;
/
-- creating package body 

create or replace package body pk_first is

    name varchar2(20) := 'niraj';
--fn implimentaion
    function print_string return varchar2 is
        begin
            return name;
        end;
-- procedure implimentation

    procedure findrec (fname varchar2, pass varchar2)
    is
    begin
        insert into demo_users (user_name, password, admin_user) values(fname, pass, 'N'); 
    end;
    
end pk_first;

/


-- use of package in plsql block

begin

dbms_output.put_line(pk_first.print_string());
pk_first.findrec('niraj', 'pass');

end;

/    
select * from demo_users;
select table_name from user_tables;



select current_date from dual;