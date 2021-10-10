create table log_table (
    id                             number not null constraint log_table_id_pk primary key,
    table_name                     varchar2(50) not null,
    table_pk                       varchar2(100) not null,
    dml_type                       varchar2(1) not null,
    change_date                    date not null,
    message                        varchar2(200)
);

create or replace trigger log_table_biu
    before insert or update 
    on log_table
    for each row
begin
    if :new.id is null then
        :new.id := to_number(sys_guid(), 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
    end if;
end log_table_biu;
/

comment on column log_table.change_date is 'last modificationd datetime of record';

comment on column log_table.dml_type is '''I'' - insert, ''U'' - update, ''D'' - delete';

comment on column log_table.message is 'additional message';

comment on column log_table.table_name is 'table name';

comment on column log_table.table_pk is 'table primary key of table beeing logged';

create or replace package pkg_log_dml 
is 
    -- Log table dml with pk 
    procedure log_table_dml(  
       ptable_name   in varchar2,  
       ptable_pk     in varchar2,  
       pdml_type      in varchar2,        
       pchange_date  in date,  
       pmessage      in varchar2); 
        
end pkg_log_dml; 
 
/

create or replace package body pkg_log_dml 
is 
    -- Log table dml with pk 
    procedure log_table_dml(  
       ptable_name   in varchar2,  
       ptable_pk     in varchar2,  
       pdml_type      in varchar2, 
       pchange_date  in date,  
       pmessage      in varchar2) 
    is 
    begin  
        insert into log_table(table_name, table_pk, dml_type, change_date, message)  
        values (ptable_name, ptable_pk,  pdml_type, pchange_date, pmessage);             
    end; 
        
end pkg_log_dml; 
 
/

create table users ( 
    id                             number not null constraint users_id_pk primary key, 
    user_corp_id                   number, 
    name                           varchar2(50), 
    surname                        varchar2(50) 
);

create or replace trigger users_aiud  
    before insert or update or delete  
    on users  
    for each row  
declare 
   wdml_type varchar2(1); 
   wtable_pk varchar2(100); 
begin  
    wdml_type := case  
        when inserting then 'I' 
        when updating then 'U' 
        when deleting then 'D' 
    end; 
    wtable_pk := nvl(:new.id, :old.id); 
    pkg_log_dml.log_table_dml(ptable_name => 'USERS', ptable_pk => wtable_pk ,  pdml_type => wdml_type, pchange_date => sysdate, pmessage => null);  
end users_aiud;
/

create or replace trigger users_biu
    before insert or update 
    on users
    for each row
begin
    if :new.id is null then
        :new.id := to_number(sys_guid(), 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
    end if;
end users_biu;
/

insert into users (
    id,
    user_corp_id,
    name,
    surname
) values (
    273743869122911051792281566785089177888,
    40,
    'Mac Prevention',
    'Fames Ac Ante Ipsum'
);

insert into users (
    id,
    user_corp_id,
    name,
    surname
) values (
    273743869122912260718101181414263884064,
    84,
    'Personal Information Security Review',
    'Aliquam Vestibulum Lacinia Arcu'
);

insert into users (
    id,
    user_corp_id,
    name,
    surname
) values (
    273743869122913469643920796043438590240,
    39,
    'Employee Automation',
    'Volutpat Risusphasellus Vitae Ligula'
);

insert into users (
    id,
    user_corp_id,
    name,
    surname
) values (
    273743869122914678569740410672613296416,
    94,
    'Deadlock Detection Review',
    'Mattis Risus Rhoncuscras Vulputate'
);

insert into users (
    id,
    user_corp_id,
    name,
    surname
) values (
    273743869122915887495560025301788002592,
    80,
    'Hyper Ledger Project',
    'Vestibulum Ante Ipsumprimis In'
);

select * from users;

delete from users where id ='273743869122911051792281566785089177888';

commit;

select * from log_table;

select * from users;

update users set name = name || ' *** updated' where id = 273743869122914678569740410672613296416;

commit;

delete from users where id ='273743869122914678569740410672613296416';

update users set name = name || ' *** updated' where id = 273743869122914678569740410672613296416;

commit;

select * from log_table;

