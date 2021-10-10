# Oracle Log Table DML activities with package and log table, also demo with USERS table..

    Author      : Orhan Çavuş
    Last Update : 10.10.2021

LOG_TABLE ise used to log  any INSERT, UPDATE, DELETE activity on any table that calls logging package pkg_log_dml.log_table_dml() prosedure

Example usage on USERS after insert/update/delete table trigger:

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
    end users_aiud

