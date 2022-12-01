-- DDL Trigger with Schema Auditing


create table schemaaudittb(
    user_name varchar(20),
    tstamp timestamp,
    objtype varchar(20),
    objname varchar(30)
);
/

alter table schemaaudittb add command varchar(20);

create or replace trigger schemaauditddl
after truncate or create or drop or rename or alter on schema
disable
declare
    u_name varchar(20);
begin
    select user into u_name from dual;
    insert into schemaaudittb values(u_name, current_timestamp, ora_dict_obj_type, ora_dict_obj_name, ora_sysevent);
end;

/
create table usersnames(id number);

select * from schemaaudittb;

truncate table empcopy;