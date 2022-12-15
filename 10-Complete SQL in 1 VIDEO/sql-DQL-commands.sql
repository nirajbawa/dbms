/*

# index in sql

The CREATE INDEX statement is used to create indexes in tables.

Indexes are used to retrieve data from the database more quickly than otherwise. The users cannot see the indexes, they are just used to speed up searches/queries.

*/


use learndb;


-- #create index 
create index upass on users(upassword);

select * from users where upassword = 'niraj@#&123' and uname = 'nirajbava111';

-- #show index

show index from users;

-- UNIQUE index

create unique index upass on users(upassword);

/*

Composite Indexes
A composite index is an index on two or more columns of a table. 

Whether to create a single-column index or a composite index, take into consideration the column(s) that you may use very frequently 
in a query's WHERE clause as filter conditions.

Should there be only one column used, a single-column index should be the choice. Should there be two or more columns
that are frequently used in the WHERE clause as filters, the composite index would be the best choice.

*/

create index upass on users(upassword, uname);

-- # alter index 
-- work in oracle
alter index upass rename to upass1; 
alter table users rename index upass to epass; 

-- #drop index 

drop index upass on users;


show tables;
select * from users;
select * from udescriptions;
desc users;Skip to content
Search or jump to…
Pull requests
Issues
Codespaces
Marketplace
Explore
 
@nirajbawa 
nirajbawa
/
dbms
Private
Code
Issues
Pull requests
Actions
Projects
Wiki
Security
Insights
Settings
dbms/10-Complete SQL in 1 VIDEO/sql-DQL-commands.sql
@nirajbawa
nirajbawa second commit
Latest commit e8f0884 last month
 History
 1 contributor
758 lines (407 sloc)  19.9 KB

-- data query language
/*
The SELECT statement is the most commonly used command in Structured Query Language. 
It is used to access the records from one or more database tables and views. 
It also retrieves the selected data that follow the conditions we want.
*/



show databases;
use learndb;

#select with out where clause select all records of tables
-- select item name 
select * from users; -- tbname

#select specific records usinh where clause
--     items select   tbname   condition       
select uname from users where uemail = 'nirajbava222@gmail.com';


-- # DISTINCT
-- The SQL DISTINCT command is used with SELECT key word to retrieve only distinct or unique data.

select distinct *  from tbtest;

-- #  COUNT
-- The SQL COUNT() is a function that returns the number of records of the table in the output.

select count(distinct id) as 'number of employees' from tbtest;


-- # TOP
-- The SELECT TOP statement in SQL shows the limited number of records or rows from the database table. 
-- The TOP clause in the statement specifies how many rows are returned.

-- select top 3 id from tbtest; -- work in SQL Server 

select * from tbtest limit 4;


-- # first
-- The SQL first() function is used to return the first value of the selected column.

-- select first(id) from tbtest; -- work in SQL Server 

select * from tbtest limit 1;

-- # order by (default asc) / desc
select * from users order by uname;  
select * from users order by uname asc; 

select * from users order by uname desc; 


-- The LAST() function in Structured Query Language shows the last value from the specified column of the table.
-- SELECT LAST (Field_Name) FROM Table_Name ;  work in SQL Server
select * from users order by uname desc limit 1; 

-- # SQL SELECT RANDOM

select * from users order by rand() limit 1;


-- #limit

select * from users limit 5;

select * from users limit 3, 4;

select * from users limit 3 offset 4;


-- # SQL Clause
	-- * where 
		select * from users where uname = 'nirajbava111';
    -- * and
		select * from users where uname = 'nirajbava111' and uemail = 'nirajbava222@gmail.com'; 
	-- * or
		select * from users where uname = 'nirajbava111' or uemail = 'nirajbava222@gmail.com'; 
	-- * SQL SELECT AS
		-- SQL 'AS' is used to assign a new name temporarily to a table column or even a table.
        select u.uname as 'user name', u.uemail as 'user email' from users as u where uname = "nirajbava111";
	
-- #sql grouping 

select count(uactype)  from udescriptions group by uactype; 

-- * sql grouping with having 

select (uactype), length(max(ubio)) from udescriptions group by uactype having length(max(ubio))>0; 


-- # in and between

-- * select all users where bio is between 
	
    select ufname, ubio from udescriptions where length(ubio) between 1 and 10; 
     select ufname, ubio from udescriptions where length(ubio) not between 1 and 5; 
    
-- * select all users where actype is in
	select ufname, uemail from udescriptions where uactype in(0,1);
    	select ufname, uemail from udescriptions where uactype not in(1);
        
        
-- # select mono where is null
select id, name, mono from dml_customers where mono is null;
-- # select mono where is not null
select id, name, mono from dml_customers where mono is not null;


-- # seaching or patter matching (like) 

-- select all records where uname is starts with s
select * from users where uname like "s%";

-- select all records where uname is end with a
select * from users where uname like '%a';

-- select all records where uname in start second character is a 
select * from users where uname like '_a%';

-- select all records where uname in starts first character is start with a with contain minimum 3 character 
select * from users where uname like 'a___%';


-- select all records where uname stats second character is a and contain minimum 4 characters
select * from users where uname like '_a____%';

-- select all records where uname in end second character is a 

select * from users where uname like '%a_';

-- select all records where uname in end last character is a and in above contain minimum 3 character

select * from users where uname like '%___a';


-- select all records where uname in end second last character is a and in above contain minimum 3 character

select * from users where uname like '%___a_';


-- select all records where uname contain a character in whole string

select * from users where uname like '%a%';

-- select all records where uname contain niraj character in whole string

select * from users where uname like '%niraj%';

-- select all records where uname is starts with niraj character and in end with 111 character

select * from users where uname like "niraj%111";

-- * not linke

select * from users where uname not like "niraj%111";


-- # sql join 

-- MySQL JOINS are used with SELECT statement. It is used to retrieve data from multiple tables. 
-- It is performed whenever you need to fetch records from two or more tables.

-- * inner join

-- The MySQL INNER JOIN is used to return all rows from multiple tables where the join condition is satisfied. It is the most common type of join.

	select u.uname, u.uemail, u.upassword, d.ufname, d.ulname, d.uactype, d.ubio from users as u inner join udescriptions as d on u.uemail=d.uemail;
    
 
    
    -- select username nirajbava111 all information
    select u.uname, u.uemail, u.upassword, d.ufname, d.ulname, d.uactype, d.ubio from users as u inner join udescriptions as d on u.uemail=d.uemail where u.uname='nirajbava111';

	
-- * outer joins
	-- * Right Outer Join
		-- The MySQL Right Outer Join returns all rows from the RIGHT-hand table specified in the ON condition 
        -- and only those rows from the other table where he join condition is fulfilled.
		
        -- select all user from first and other table select there info 
        select u.uemail, u.uname, u.upassword, d.ufname, d.ulname, d.ubio from users as u right join udescriptions as d on u.uemail=d.uemail;
		
		-- * left join
		/*
        The Right Join is used to joins two or more tables and returns all rows from the right-hand table, 
        and only those results from the other table that fulfilled the join condition. 
        If it finds unmatched records from the left side table, it returns Null value. It is similar to the Left Join, 
        except it gives the reverse result of the join tables. It is also known as Right Outer Join. 
        So, Outer is the optional clause used with the Right Join.
        */
	
		select * from dml_customers as u left join dml_customers_order_com as d on u.id=d.custid;
        
        -- * FULL JOIN
        /*
        The SQL full join is the result of combination of both left and right outer join and the join tables have all the records from both tables. 
        It puts NULL on the place of matches not found.
        */
		
        -- select * from dml_customers as u outer join dml_customers_order_com as d on u.id=d.custid; -- work in oracle
        
        select * from dml_customers as u right join dml_customers_order_com as d on u.id=d.custid
        union
        select * from dml_customers as u left join dml_customers_order_com as d on u.id=d.custid;
        
        -- * Cross Join
        /*
			Join operation in SQL is used to combine multiple tables together into a single table.
        */
        
        select * from dml_customers as u cross join dml_customers_order_com as d;
        
        -- * self join
        
        -- . It is used to get the output from a particular table when the same table is joined to itself.
        
        select * from dml_customers as u inner join dml_customers as d on u.name=d.name;
        
		-- * inner Join without using inner join keywords
        
        select * from users as u, udescriptions as d where u.uemail=d.uemail;
        
        
        -- SET OPERATIONS
        -- Used to combine multiple select statements.
        -- Always gives distinct rows.
        
        -- * union
        
        -- Number of column, order of column must be same for table1 and table2
        select * from dml_customers as u 
        union 
        select * from dml_customers as d;
		
        -- * INTERSECT
        -- Returns common values of the tables (Emulated)
        
        select distinct name from dml_customers as u inner join dml_customers using(name);
        
       
        -- * minus
        
        -- This operator returns the distinct row from the first table that does not occur in the second table
        
        select * from dml_customers left join dml_customers as d using(name) where name is null;
        
        
-- # Sub Query

/*
A Subquery is a query within another SQL query and embedded within the WHERE clause.
Important Rule:
A subquery can be placed in a number of SQL clauses like WHERE clause, FROM clause, HAVING clause.
You can use Subquery with SELECT, UPDATE, INSERT, DELETE statements along with the operators like =, <, >, >=, <=, IN, BETWEEN, etc.
A subquery is a query within another query. The outer query is known as the main query, and the inner query is known as a subquery.
Subqueries are on the right side of the comparison operator.
A subquery is enclosed in parentheses.
In the Subquery, ORDER BY command cannot be used. But GROUP BY command can be used to perform the same function as ORDER BY command.
*/
        


-- * Inside a WHERE clause

select * from udescriptions as u where uactype in (select uactype as c from udescriptions where uactype = 1);

-- * Subquery using FROM clause

select * from (select count(uactype) as 'pro users' from udescriptions where uactype = 1) as b, (select count(uactype) as 'none pro users' from udescriptions where uactype = 0) as d;

-- * Subquery using SELECT
select  (select ufname from udescriptions where uemail = u.uemail) as name , uemail, uname, upassword from users as u;

-- * Derived Subquery

select uemail, ufname from (select * from udescriptions where uactype between 0 and 1) as u order by u.ufname desc;


-- Co-related sub-queries

select * from udescriptions where uemail in (select uemail from users );


-- subquery with update 

 update udescriptions
 set ubio = 'no'
 where  uactype in (select uactype from udescriptions where uactype = 1 and ubio = 'nothing');

-- subquery with delete 

delete from users where upassword in (select upassword from users where length(upassword) <8);

 
-- #  Aggregate Functions

-- SQL aggregation function is used to perform the calculations on multiple rows of a single column of a table. It returns a single value.
-- It is also used to summarize the data.


select count(*) from users;

select max(length(uname)) from users;   

select  min(length(uname)) from users;

select sum(uactype) from udescriptions where uactype = 1;

select avg(uactype) from udescriptions where uactype = 1;


-- https://www.w3schools.com/mysql/mysql_ref_functions.asp

-- # Numeric Functions

select abs(-2.3);

select ceil(2.4);

select floor(2.4);

select truncate(2.2666,1);

select round(2.5);

select exp(1);

select power(4,2);

select sqrt(10);

select mod(10,3);

select degrees(2.5);

select cos(5);

select 10 div 5;

select greatest(1,2,3,4,5);

select least(1,2,3,4,5);

select log(1);

select log10(2);

select pi();

select pow(4,2), power(4,2);

select radians(180);

select rand(),  round(rand()*(100-0)+0);

select tan(10);

-- # String Functions


-- 	Returns the ASCII value for the specific character
select ascii('n');

-- 	Returns the length of a string (in characters)
select char_length('niraj'), character_length('niraj'), length('niraj');


-- 	Adds two or more expressions together
select concat('niraj', 'bava','engineer');

-- 	Adds two or more expressions together with a separator
				-- spaerator
select concat_ws('-','niraj','bava');

-- Returns the index position of a value in a list of values
--          search key
select field('d','a','q','d');

-- 	Returns the position of a string within a list of strings
select find_in_set('n','a,v,n');

-- Formats a number to a format like "#,###,###.##", rounded to a specified number of decimal places

select format(2222220500, 2);

-- Inserts a string within a string at the specified position and for a certain number of characters

select insert('niraj.com', 1, 5, 'google');

-- Returns the position of the first occurrence of a string in another string

select instr('nirajbava', 'n');

-- 	Converts a string to upper-case

select ucase('niraj'), upper('niraj');

-- 	Converts a string to lower-case

select lcase('niraj'), upper('niraj');

-- Extracts a number of characters from a string (starting from left)

select left('niraj', 3);

-- Extracts a number of characters from a string (starting from right)
select right('niraj', 3);

-- 	Returns the position of the first occurrence of a substring in a string

select locate('i', 'niraj');

-- 	Left-pads a string with another string, to a certain length

select lpad('nirajabava',20, '***');

-- 	Right-pads a string with another string, to a certain length

select rpad('nirajbava', 20, '******');

-- 	Removes leading spaces from a string

select ltrim('    niraj');

-- 	Removes trailing spaces from a string

select rtrim('niraj     ');

-- 	Removes leading and trailing spaces from a string

select trim('     niraj    ');

-- Extracts a substring from a string (starting at any position)

select mid('niraj bava', 1, 5), substr('niraj bava', 1,5), substring('niraj bava', 1,5);

-- Returns the position of the first occurrence of a substring in a string

select position('i' in 'niraj');

-- Returns the position of the first occurrence of a substring in a string

select repeat('niraj bava', 3);

-- 	Replaces all occurrences of a substring within a string, with a new substring

SELECT REPLACE('niraj bava', 'niraj', 'u');

-- 	Reverses a string and returns the result

select reverse('nirajbava');

-- Returns a string of the specified number of space characters

select space(10);

-- Compares two strings

select strcmp('niraj bava', 'niraj bava');

-- 	Returns a substring of a string before a specified number of delimiter occurs

select substring_index('www.niraj.ncom', 'n', 2);


-- # Date Functions

-- 	Adds a time/date interval to a date and then returns the date

select adddate('2022-06-01', interval 10 day), date_add('2022-06-01', interval 10 day);

-- 	Adds a time interval to a time/datetime and then returns the time/datetime

select addtime('2022-06-15 09:00:00', 10000);

-- Returns the current date

select curdate();

select current_date();

-- 	Returns the current time

select current_time(), curtime();

-- Returns the current date and time

select current_timestamp();

-- Extracts the date part from a datetime expression

select date('2022-06-05');

-- Returns the number of days between two date values

select datediff('2022-12-15', '2022-11-17');


-- Formats a date

select date_format('2022-01-01', '%d');

-- Subtracts a time/date interval from a date and then returns the date

select date_sub('2022-01-01', interval 10 day);

-- 	Returns the day of the month for a given date

select day('2022-01-02');

-- 	Returns the weekday name for a given date

select dayname('2022-11-16');

-- Returns the weekday index for a given date

select dayofweek('2022-11-16');

-- 	Returns the day of the year for a given date

select dayofyear('2022-11-16');

-- 	Extracts a part from a given date

select extract(month from '2022-06-15 11:52:00');


-- Returns a date from a numeric datevalue

select from_days(485554);

-- Returns a date from a numeric datevalue

select hour('2022-06-15 11:52:00');

-- Extracts the last day of the month for a given date

select last_day('2022-06-15');

-- 	Returns the current date and time

select localtime();

-- 	Returns the current date and time

select localtimestamp();

-- 	Creates and returns a date based on a year and a number of days value
select makedate(2022, 321);

-- 	Creates and returns a date based on a year and a number of days value

select maketime(11, 35, 4);

-- Returns the microsecond part of a time/datetime

select microsecond('2022-06-15 11:52:00.1');

-- 	Returns the minute part of a time/datetime

select minute('11:52:00');

-- Returns the month part for a given date

select month('2022-06-15 11:52:00');


-- 	Returns the name of the month for a given date

select monthname('2022-11-15');

-- 	Returns the current date and time

select now();

-- 	Adds a specified number of months to a period
-- 	Required. A period. Format: YYMM or YYYYMM
select period_add(202203, 5);

-- 	Returns the difference between two periods

select period_diff('202205', '202203');


-- 	Returns the quarter of the year for a given date value

select quarter('2022-11-17');

-- 	Returns the seconds part of a time/datetime

select second('11:52:02');
 
 
 -- Returns a time value based on the specified seconds
 
 select sec_to_time(1);

-- 	Returns a date based on a string and a format

select str_to_date(' 10 august 2017', '%d %M %Y');

-- Subtracts a time/date interval from a date and then returns the date 

select subdate('2022-06-15', interval 10 day);

-- 	Subtracts a time interval from a datetime and then returns the time/datetime

select subtime('11:52:00', '50000');

-- Returns the current date and time

select sysdate();

-- 	Extracts the time part from a given time/datetime

select time('2022-06-15 11:52:00');

-- Formats a time by a specified format

select time_format('10:20:00', "%H %i %s");


-- 	Converts a time value into seconds 

select time_to_sec('10:20:00');

-- 	Returns the difference between two time/datetime expressions

select timediff('10:20:00', '1:20:00');

-- Returns a datetime value based on a date or datetime value

select timestamp('2022-06-15', '11:52:00');


-- 	Returns the number of days between a date and date "0000-00-00"

select to_days('2022-06-15');

-- 	Returns the week number for a given date

select week('2022-06-15');

-- 	Returns the weekday number for a given date

select weekday('2022-06-15');

-- 	Returns the week number for a given date

select weekofyear('2022-06-15');

-- 	Returns the year part for a given date

select year('2022-06-15');

-- 	Returns the year and week number for a given date

select yearweek('2022-06-15');

--  # Advanced Functions

-- Returns a binary representation of a number

select bin(100);

-- 	Goes through conditions and return a value when the first condition is met

select uname, uemail,
case 
	when uname = "nirajbava111" then "niraj"
    when uname = "raj@131" then "raj"
    else "no"
end as com
from users;

-- 	Converts a value (of any type) into a specified datatype
select cast("2022-05-06" as date);

-- 	Returns the first non-null value in a list
select coalesce(null,null,"niraj", null);

-- Returns the unique connection ID for the current connection
select connection_id();

-- 	Converts a number from one numeric base system to another
--        value  currentbase
select conv(1111, 2, 10); -- convert to base

-- 	Converts a value into the specified datatype or character set

select convert('2022-08-29', date);

-- 	Returns the name of the current database

select database();

-- 	Returns a value if a condition is TRUE, or another value if a condition is FALSE
select ubio, if(length(ubio) > 5, ubio, "none") from udescriptions;

-- Return a specified value if the expression is NULL, otherwise return the expression

select ufname, ifnull(ubio, "this is null") from udescriptions;-

-- 	Returns 1 or 0 depending on whether an expression is NULL
-- if return 1 then null else 1
select ufname, isnull(ubio) from udescriptions;

-- Returns the AUTO_INCREMENT id of the last row that has been inserted or updated in a table

select  last_insert_id();

-- 	Compares two expressions and returns NULL if they are equal. Otherwise, the first expression is returned

select nullif(25, 22);

-- Returns the user name and host name for the MySQL account that the server used to authenticate the current client

select current_user();


-- Returns the current MySQL user name and host name

select session_user();

-- Returns the current MySQL user name and host name

select system_user();

-- 	Returns the current MySQL user name and host name


select user();

-- Returns the current version of the MySQL database

select version();

show tables;
select * from users;
select * from udescriptions;

desc users;



