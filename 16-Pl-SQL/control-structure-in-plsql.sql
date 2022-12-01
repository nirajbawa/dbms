-- control structure statements

-- # conditional statements

-- * if then

set serveroutput on;

declare
    num number;
begin
    num := &num;
    if num=20 then  
        dbms_output.put_line('your age greater than 20 or equal to 20');
    end if;
end;
/

-- * if then else

declare 
    num number := &num;
begin
    if mod(num,2)=0 then
        dbms_output.put_line('number is even');
    else 
        dbms_output.put_line('number is odd');
    end if;
end;
/

-- * if then elsif 

declare 
    name varchar(20) := '&name';
begin
    if name='niraj' then
        dbms_output.put_line('you are coder');
    elsif name='rahul' then 
        dbms_output.put_line('you are not coder');
    elsif name='shayam' then
        dbms_output.put_line('you are farmer');
    else
        dbms_output.put_line('invalid input');
    end if;
end;
/

-- # loops

-- * simple loop

declare
    num number;
    counts number := 1;
    result number;
begin
    num := &num;
    
    dbms_output.put_line('table of : ' || num);
    
    loop
        result:= num*counts;
        dbms_output.put_line(num||' * '||counts||' = '||result);
        counts:=counts+1;
        if counts > 10 THEN
            exit;
        end if;
    end loop;
end;
/
-- simple loop using exit when
declare
    num number;
    counts number := 1;
    result number;
begin
    num := &num;
    
    dbms_output.put_line('table of : ' || num);
    
    loop
        result:= num*counts;
        dbms_output.put_line(num||' * '||counts||' = '||result);
        counts:=counts+1;
        exit when counts>10;
    end loop;
end;
/
-- while loop

declare 
    num number := 10;
    i number := 1;
begin
    while i<=num loop
        dbms_output.put_line(i);
        i := i+1;
    end loop;
end;
/

declare 
    flag boolean := true;
    i number := 1;
begin
    while flag loop
        dbms_output.put_line(i);
        i := i+1;
        if i > 10 then
            flag := false;
        end if;
    end loop;
end;
/

declare
    this_num number;
    this_i number:=1;
    this_res number;
begin
    this_num := &this_num;
    while this_i<=10 loop
        this_res := this_num*this_i;
        dbms_output.put_line(this_num||' * '||this_i||' = '||this_res);
        this_i := this_i+1;
    end loop;

end;
/

-- * numeric for loop

declare 
    N_num number;
begin
    for n_num in 1..10 loop
        dbms_output.put_line(n_num);
    end loop;
end;
/

declare
    n_num number:=&n_num;
    n_res number;
    N_count number;
    n_incount number;
begin
    for n_count in 1..n_num loop
        dbms_output.put_line('table of : '||n_count);
        for n_incount in 1..10 loop
          n_res := n_count*n_incount;
          dbms_output.put_line(n_count||' * '||n_incount||' = '||n_res);
        end loop;
    end loop;
end;

