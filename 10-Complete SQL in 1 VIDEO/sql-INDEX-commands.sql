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

Whether to create a single-column index or a composite index, take into consideration the column(s) that you may use very frequently in a query's WHERE clause as filter conditions.

Should there be only one column used, a single-column index should be the choice. Should there be two or more columns that are frequently used in the WHERE clause as filters, the composite index would be the best choice.

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
desc users;