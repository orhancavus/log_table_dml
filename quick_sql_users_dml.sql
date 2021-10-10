
quick sql

users /insert 5
  user_corp_id num
  name vc50
  surname vc50
-------------------------------------------------------------------------------------

create table users (
    id                             number not null constraint users_id_pk primary key,
    user_corp_id                   number,
    name                           varchar2(50),
    surname                        varchar2(50)
)

create or replace trigger users_biu
    before insert or update 
    on users
    for each row
begin
    if :new.id is null then
        :new.id := to_number(sys_guid(), 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
    end if;
end users_biu;

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