-- #SYNONYM

/*

A synonym is merely another name for a table or a view. Synonyms are usually created so a user 
can avoid having to qualify another user’s table or view to access the table or view. 
Synonyms can be created as PUBLIC or PRIVATE. Any user of the database can use a PUBLIC synonym;
only the owner of a database and any users that have been granted privileges can use a PRIVATE synonym.

All users can generally create a PRIVATE synonym. Typically, only a DBA or privileged database user can create a PUBLIC synonym.

*/ 

use learndb;

-- #create synonym in oracle

-- * create public synonym (this is accessed by all user on dbms require grants)
--             for all users     name        username  tablename
create public synonym userdisy for user.users;

create public synonym userdisy for users;

-- * select data from synonym 

select * from userdisy;

-- * create private (this is not access by root user untill permission)

grant create public synonym to user;
grant create any synonym to user;

create synonym userdisy for user.users;

create synonym userdisy for users;

-- * all dml operations work with synonym 

-- # drop synonym

-- * drop private synonym

DROP SYNONYM userdisy FORCE;
DROP SYNONYM userdisy;

-- * drop public synonym
DROP PUBLIC SYNONYM userdisy FORCE;


-- mysql synonym (can't create synonym for table in mysql but create for database)

call sys.create_synonym_db('learndb', 'ldb');
DROP DATABASE ldb;

