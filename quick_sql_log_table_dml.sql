log_table   
  table_name     vc50/nn   -- table name
  table_pk       vc100/nn  -- table primary key of table beeing logged
  dml_type       vc1/nn    -- 'I' - insert, 'U' - update, 'D' - delete
  change_date    date/nn   -- last modificationd datetime of record
  message        vc200     -- additional message

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
