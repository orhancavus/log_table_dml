-- 
-- Author         : Orhan Çavuş
-- Last Modified  : 10.20.202
-- 1. USERS       : demo table, after insert, update, delete trigger fires for logging with
--    pkg_log_dml.log_table_dml() 
-- 

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


