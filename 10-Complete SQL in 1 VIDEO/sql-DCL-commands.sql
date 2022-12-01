-- data control language

-- # check users in dbms system
select * from mysql.user;

--            user-name (@localhost is hostname)  
show grants for root@localhost;

-- # show current user
select current_user();

-- # create user (when we created new user than we not any permission of db)
--            uname       host                     pass
create user application@localhost identified by 'app@#&13';

create user test2@localhost identified by 'test2';



show grants for application@localhost;

-- # drop user
--          uname
drop user application;


-- # grant
-- permissions   object       username    hostname 
grant all on learndb.* to application@localhost;

-- grant on specific table
grant select on learndb.test to test2@localhost; 

show grants for test2@localhost;

revoke all on learndb.tbtest from test2@localhost;

-- grant only specific column
grant select(id, address) on learndb.tbtest to test2@localhost; 

grant all on * to test2@localhost;

-- # grant with grant

grant select, update, insert on learndb.* to rahul@localhost with grant option;

-- # revoke
-- permissions  object        uname          host
revoke all on learndb.* from application@localhost;

revoke all on * from rahul@localhost;

use learndb;
show tables;
desc tbtest;





