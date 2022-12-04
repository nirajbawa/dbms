/*

-What are PL/SQL Collections in Oracle Database?

A homogeneous single dimension data structure which is made up of elements of same datatype is called collection in Oracle Database.
In simple language we can say that, an array inOracle Database is called Collection.



-Definition
A homogeneous single dimension data structure which is made up of elements of same datatype is 
called collection in Oracle Database.


-Why we call collection a homogeneous data structure?

As we know that array consists data of same datatype and so does the PL/SQL collection which is 
why we call them homogeneous data structure.

The structure of PL/SQL collections consist of a cell with subscript called index. Data is stored
into these cells and can be identified and accessed using the index number. This is again very 
similar to the structure of arrays, but unlike array PL/SQL Collections are strictly one-dimensional.

                                index(i)
                                data(d)

The collection in Oracle Database are strictly One-Dimensional. It is not possible to realize them on 2D co-ordinates.
However when the collection has an attribute of object type or collection type then it is possible to realize a multi-dimensional array.


- Types of PL/SQL Collections in Oracle Database

PL/SQL collections can be divided into two categories:

1.Persistent and
2.Non-persistent.

Persistent collection, as the name suggests, are those which physically store the collection structure with the data into the database and 
can be accessed again if needed. Whereas non-persistent collection only stores data and structure for one session.


                                        collections 
                                |                             |
                            persistent               variable size or vArray
                 |                          |          |             
            nested tables                varrays      associative arrays
            
            

-Nested Table – Nested tables are persistent collection which means they can be stored into the database and can be reused. Nested tables has 
no upper limits on rows thus they are unbounded collections. Nested tables are initially dense but can become sparse through deletion.

-VARRAYs – Similar to Nested tables Variable-Sized Arrays are also persistent collections thus they can be created in database as well as 
PL/SQL block and can be reused.  But unlike nested tables VARRAYs are bounded in nature which means that they can hold only a fixed amount of elements.

The size and storage schema of VARRAYs makes them different from nested tables.


- Associative Array – Unlike nested table and VARRAYs, associative arrays are non-persistent collections thus they cannot be stored into the database. Since they
cannot be store hence they cannot be reused but they are available in PL/SQL block for the session. But similar to nested tables associative 
arrays are unbounded which means they also don’t have lower and upper limits on rows.


-- Commonly used terms in PL/SQL Collection.

- Bounded & Unbounded Collection – 
A collection which has lower or upper limits on values of row number or say a collection which can hold only limited number of elements are called bounded collections. A collection 
which has no lower or upper limits on row numbers are called unbounded collections.

- Dense & Sparse Collection. – Collections is said to be dense if all the rows between the first and the last are defined and given a value. And a collection in which rows 
are not defined and populated sequentially are called sparse collection.





reference http://www.rebellionrider.com/introduction-to-pl-sql-collections-in-oracle-database/#.WLA3afl97IU






*/



set serverout on;
/

declare 
    type ns_table is table of number;
    
    a ns_table := ns_table(1,2,3,4,5);
begin  

    dbms_output.put_line('value at index 1 is : '||a(1));

end;
/


-- create nested table collection

declare 
    type ns_table is table of number;
    
    a ns_table := ns_table(1,2,3,4,5);
begin  
    
    for i in 1..a.count loop
        dbms_output.put_line('value at index '|| i ||' is : '||a(i));
    end loop;
end;
/


-- Create Nested table as Database Object

create or replace type ns_table is table of varchar2(10);
/

 create table cust (
    id number,
    name varchar(20),
    prods ns_table
)nested table prods store as ns_table_space;
/

desc cust;
/

insert into cust (id, name, prods) values(12, 'niraj', ns_table('mobile', 'earphone')); 

insert into cust (id, name, prods) values(12, 'bava', ns_table('mobile', 'earphone', 'chocolate')); 

select * from cust;

update cust set prods = ns_table('none') where id = 12;

/



-- create nested tables using user define datatype

create or replace type obj as object(
    obj_id number,
    obj_name varchar(20)
);


/
drop type obj;
/

create or replace type ts_col is table of obj;
/
create table basetb (
    t_id number,
    objs ts_col
)nested table objs store as ts_space;

/

select * from basetb;
/
insert into basetb(t_id, objs) values (21, ts_col(obj(21, 'dfsf')));
/


SELECT b.obj_id, b.obj_name, a.t_id FROM TABLE(
  SELECT objs FROM basetb WHERE t_id = 21
) b, basetb a where a.t_id = b.obj_id;


/

-- How to Create VARRAYs inside PL/SQL Block


declare 
    type varr is varray (5) of number;
    -- arr varr := varr(1,1,1,1,1);
    arr varr := varr();
begin
    arr.extend(5);
    for i in 1..arr.limit
    loop
        arr(i) := 10*i;
        dbms_output.put_line(arr (i));
    end loop;
    
end;
/


--  create VARRAY as Database Object


create or replace type varr is varray (5) of number;
/
alter type varr modify limit 6;
/
create table temps(
    name varchar2(20),
    prods varr 
);
/


insert into temps values('niraj', varr(1,2,3));
/
select * from temps;
/
select a.name, b.column_value from temps a, table(a.prods) b;
/
select b.name, a.* from table(select prods from temps) a, temps b;
/
update temps set prods = varr(1,2) where name = 'niraj';
/
drop type varr force;
/

-- Collection Associative Array


declare 
    type Aarr is table of number index by varchar(20);
    arr Aarr;
    flag varchar(20);
begin
    arr('name') := 12;
    arr('age') := 123;
    arr('address') := 1234;
    
    dbms_output.put_line('name : '||arr('name'));
    dbms_output.put_line('age : '||arr('age'));
    dbms_output.put_line('address : '||arr('address'));
    
    flag := arr.first;
    
    while flag is not null loop
        dbms_output.put_line('key -> '||flag|| 'values ->' || arr(flag));
        flag := arr.next(flag);
    end loop;
end;
/


/*
-- What are Collection Methods?

 Collection methods are PL/SQL’s in-built functions and procedures which can be
 used in conjunction with collections.


-- So, what they can do for you?
Using PL/SQL collection method you can get the information as well as alter the content of the collection.


-- How many collection methods do we have?
In Oracle Database we have 3 Collection Procedures and 7 Collection functions. In total we have 
10 collection methods. Here are their names


- Collection Functions

Count
Exists
First, Last
Limit
Prior, Next

- Collection Procedures

Delete
Extend
Trim


Since the syntax for using the collection built-ins is different from the normal 
syntax used to call procedures and functions therefore they are referred to as methods.


-- How do we use collection methods?

In Oracle PL/SQL, collection methods can be used using Dot (.) notation. Let’s take 
a look at the syntax.

Collection. Method (parameters) 


*/

set serverout on;

-- collection method count

declare 
    type nes_table is table of number;
    arr nes_table := nes_table(10,20,30,50,60);
 
begin
    
    
    for i in 1..arr.count loop
        dbms_output.put_line('enter ' || i || ' elements of array : ' || arr(i));
    end loop;

end;
/


-- collection method exists

declare 
    type nes_table is table of number;
    arr nes_table := nes_table(10,20,40,50,60);
    
begin
    
    
    if arr.exists(1) then
          dbms_output.put_line('elemenet is : ' || arr(4));
    else
         dbms_output.put_line('element is : none');
    end if;
    

end;
/

declare 
    type nes_table is table of number;
    arr nes_table := nes_table(10,20,30);
 
begin
    
    
    if arr.exists (4) then
          dbms_output.put_line('elemenet is : ' || arr(4));
    else
         dbms_output.put_line('elemenet is : none ');
        arr.extend;
         arr(4) := 40;
    end if;
    dbms_output.put_line('new data at 4 is '|| arr(4)); 

end;

/

declare 
    type nes_table is table of number;
    arr nes_table := nes_table(10,20,30);
 
begin
    
    
    if arr.exists (4) then
          dbms_output.put_line('elemenet is : ' || arr(4));
    else
         dbms_output.put_line('elemenet is : none ');
        arr.extend;
         arr(4) := 40;
    end if;
    dbms_output.put_line('new data at 4 is '|| arr(4)); 

end;
/

-- Collection Method FIRST & LAST 


declare 
    type nes_table is table of number;
    arr nes_table := nes_table(10,20,30);
 
begin
    
    
   dbms_output.put_line('first index of the nested table is '||arr.first);
   dbms_output.put_line('last index of the nested table is '||arr.last);
    
end;
/
declare 
    type nes_table is table of number;
    arr nes_table := nes_table(10,20,30);
 
begin
    
    arr.delete(1);
   dbms_output.put_line('first index of the nested table is '||arr.first);
    
end;
/

declare 
    type nes_table is table of number;
    arr nes_table := nes_table(10,20,30,40);
 
begin
    
    arr.trim();
   dbms_output.put_line('last index after trim is '||arr.last);
    
end;
/

declare 
    type nes_table is table of number;
    arr nes_table := nes_table(10,20,30,40);
 
begin
    
   dbms_output.put_line('the value at index first : '||arr(arr.first));
    dbms_output.put_line('the value at index last : '||arr(arr.last));
end;
/

-- Collection Method LIMIT


declare 
    type nes_table is varray(5) of number;
    arr nes_table := nes_table(10,20,30,40);
 
begin
    
   dbms_output.put_line('limit : '||arr.limit);
    dbms_output.put_line('count : '||arr.count);
end;
/
-- Collection Method Prior & next

declare 
    type nes_table is varray(5) of number;
    arr nes_table := nes_table(10,20,30,40);
 
begin
    
   dbms_output.put_line('index number before 3 : '||arr.prior(3));
   dbms_output.put_line('index before 3 and it value : '||arr(arr.prior(3))); 
end;
/


declare 
    type nes_table is varray(5) of number;
    arr nes_table := nes_table(10,20,30,40);
 
begin
    
   dbms_output.put_line('index number after 3 : '||arr.next(3));
   dbms_output.put_line('index after 3 and it value : '||arr(arr.next(3))); 
end;
/

-- Collection Method Delete 

declare 
    type nes_table is table of number;
    arr nes_table := nes_table(10,20,30,40,40);
 
begin
   dbms_output.put_line('value at index 3 before delete '||arr(3));
   arr.delete(3);
   
    if arr.exists(3) then 
        dbms_output.put_line('value : '||arr(3));
    else
        dbms_output.put_line('data is deleted');
    end if;
end;
/




declare 
    type nes_table is table of number;
    arr nes_table := nes_table(10,20,30,40,4450);
 
begin

   arr.delete(1,3);
   
   for i in arr.first..arr.last loop
        if arr.exists(i) then
            dbms_output.put_line('value at index '||i||' is '|| arr(i));
        end if;
   end loop;
   
end;
/


declare 
    type nes_table is table of number;
    arr nes_table := nes_table(10,20,30,40,4450);
 
begin

   arr.delete();

    if arr.exists(1) then
        dbms_output.put_line('values is '|| arr(1));
    end if;

   
end;
/

-- Collection Method EXTEND 


declare 
    type nes_table is table of number;
    arr nes_table := nes_table(10,20,30,40,4450);
 
begin

   arr.extend();
   arr(1) := 20;
   dbms_output.put_line('data at index 1 is '||arr(1));
   
end;
/

declare 
    type nes_table is table of number;
    arr nes_table := nes_table(10,20,30,40,4450);
 
begin

   arr.extend(3);
   arr(1) := 120;
   arr(2) := 110;
   arr(3) := 30;
   dbms_output.put_line('data at index 1 is '||arr(1));
   dbms_output.put_line('data at index 2 is '||arr(2));
   dbms_output.put_line('data at index 3 is '||arr(3));
end;
/

declare 
    type nes_table is table of number;
    arr nes_table := nes_table();
 
begin
    arr.extend();
    arr(1):=20;
    
    dbms_output.put_line('value at 1 index is : '||arr(1)||chr(10));
    
    arr.extend(5,1);
    
    for i in arr.next(arr.first)..arr.last loop
        dbms_output.put_line('values at '||i||' index is : '||arr(i)||chr(10));
    end loop;
    
end;
/


-- Collection Method TRIM

declare 
    type nes_table is table of number;
    arr nes_table := nes_table(10,20,30,40,50);
 
begin
    
    arr.trim(3);

    dbms_output.put_line('value after trim'||chr(10));
    
    
    for i in arr.first..arr.last loop
        dbms_output.put_line('values at '||i||' index is : '||arr(i)||chr(10));
    end loop;
    
end;
/


