/*

Any abnormal condition or say event that interrupts the normal flow of your program’s 
instructions at run time is an exception. Or in simple words you can say an exception is a run time error.

-- Exceptions are designed for run time error handling rather than compile time error handling. Errors that 
occur during compilation phase are detected by the PL/SQL compiler and reported back to the user.


- Types of exceptions
There are two types of PL/SQL exceptions in Oracle database.

*System-defined exceptions and

-- system define exceptions : https://www.tutorialspoint.com/plsql/plsql_exceptions.htm#

*User-defined exceptions

- System-Defined Exceptions
System-defined exceptions are defined and maintained implicitly by the Oracle server. These exceptions are mainly defined in the Oracle 
STANDARD package. Whenever an exception occurs inside the program. The Oracle server matches and identifies the appropriate exception from the available set of exceptions.

System defined exceptions majorly have a negative error code and error message. These errors have a short name which is used with the exception handler.


- Oracle avails two utility functions SQLCODE & SQLERRM to retrieve the error code and message for last occur exception.


- User-Define Exceptions

Unlike System-Define Exception, User-Define Exceptions are raised explicitly in the body of the PL/SQL block 
(more specifically inside the BEGIN-END section) using the RAISE Statement.



-- How to Declare a User-Define Exception in Oracle Database.


# There are three ways of declaring user-define exceptions in Oracle Database.


- By declaring a variable of EXCEPTION type in declaration section.

You can declare a user defined exception by declaring a variable of EXCEPTION datatype in your code and
raise it explicitly in your program using RAISE statement and handle them in the Exception Section.


- Declare user-defined exception using PRAGMA EXCEPTION_INIT function.

Using PRAGMA EXCEPTION_INIT function you can map a non-predefined error number with the variable of EXCEPTION datatype.  
Means using the same function you can associate a variable of EXCEPTION datatype with a standard error.


- RAISE_APPLICATION_ERROR method.

Using this method you can declare a user defined exception with your own customized error number and message.



reference : http://www.rebellionrider.com/how-to-declare-user-define-exception-using-an-exception-variable-in-oracle-database/#.WHCUA_l97IU



*/



-- system defined exceptions

declare
    name demo_users.user_name%type;
    id number;
begin
    id := &id;
    select user_name into name from demo_users where user_id = id;
    dbms_output.put_line(name);
    exception
        when no_data_found then 
            dbms_output.put_line('not data found');
        when others then
            dbms_output.put_line('error');
end;

/

select * from demo_users;

/

-- declare user-define exception using a EXCEPTION variable

set serverout on;
/

declare

dividend number;
divisor number;
total number;
ex_zero exception;

begin

dividend := &dividend;
divisor := &divisor;

if divisor=0 then
    raise ex_zero;
end if;

total := dividend/divisor;
dbms_output.put_line('result = '||total);

exception 
when ex_zero then 
    dbms_output.put_line('error error !- your divisor is zero');
end;
/

-- User-Define Exception using RAISE_APPLICATION_ERROR


accept var_age number prompt 'what is your age?';

declare
age number := &age;
begin
if age<18 then
    -- error code between 20000 - 20999
    raise_application_error('-20008','your age is less than 18 so you can not drive the car');
end if;

dbms_output.put_line('your age greater than 18 so you eligible for driving the car');


exception 
when others then
    dbms_output.put_line(sqlerrm);
end;
/

--  Declare user define exception using PRAGMA EXCEPTION_INIT

accept age number prompt 'enter your age : ';

declare
    age number;
    ex_age exception;
    pragma exception_init(ex_age,-20008);
    
begin
    age := &age;
    
    if age<18 then
        raise_application_error(-20008, 'your age is less than 18 so you can not drive the car');
    end if;
    
    dbms_output.put_line('your age greater than 18 so you eligible for driving the car');

exception

    when ex_age then
        dbms_output.put_line(sqlerrm);

end;














