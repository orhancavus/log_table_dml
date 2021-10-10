-- 
-- Author         : Orhan Çavuş
-- Last Modified  : 10.20.2021
-- 1. LOG_TABLE   : holds DML operations on table
-- 2. pkg_log_dml : package used to track DML operation that will be called from aiud triggers 
--    usage : pkg_log_dml.log_table_dml(ptable_name => 'USERS', ptable_pk => wtable_pk ,  pdml_type => wdml_type, pchange_date => sysdate, pmessage => null); 
-- 
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