-- Transaction Control Language(TCL) commands are used to manage transactions in the database.

/*
TCL Commands in SQL
In SQL, TCL stands for Transaction control language.
A single unit of work in a database is formed after the consecutive execution of commands is known as a transaction.
There are certain commands present in SQL known as TCL commands that help the user manage the transactions that take place in a database.
COMMIT. ROLLBACK and SAVEPOINT are the most commonly used TCL commands in SQL.
Now let us take a deeper dive into the TCL commands of SQL with the help of examples. All the queries in the examples will be written using the MySQL database.
*/

use learndb;


-- In mysql we need to set variable autocommit = 0 to turn off auto commit it is defaultly on

 SET autocommit = 0;    


-- # commit
commit;

insert into users values ('suraj', 'suraj444@gmail.com', 'suraj4575@##');

insert into udescriptions values ('suraj444@gmail.com', 'suraj', 'raow', 1, 'nothing');

-- # rollback to last commit

rollback;

-- # create savepoint

insert into users values ('raman', 'raman@gmail.com', 'raman@##');

insert into udescriptions values ('raman@gmail.com', 'raman', 'chaudhary', 1, 'yes');

savepoint s1;

insert into users values ('raju', 'raju@gmail.com', 'raju@##');

insert into udescriptions values ('raju@gmail.com', 'raju', 'rawat', 1, 'yes');

-- # rollback to savepoint 

rollback to s1;

savepoint s2;

insert into users values ('samir', 'samir@gmail.com', 'raju@##');

insert into udescriptions values ('samir@gmail.com', 'samir', 'surywanshi', 1, 'yes');

rollback to s1;

rollback;

rollback to s2;

savepoint s3;


insert into users values ('shayam', 'shayam@gmail.com', 'shayam@##');

insert into udescriptions values ('shayam@gmail.com', 's', 'l', 0, '','');

rollback to s1;
rollback to s3;

commit;

show tables;
select * from users;
select * from udescriptions;

truncate table udescriptions;
delete from users;

