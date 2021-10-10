log_table   
  table_name     vc50/nn   -- table name
  table_pk       vc100/nn  -- table primary key of table beeing logged
  dml_type       vc1/nn    -- 'I' - insert, 'U' - update, 'D' - delete
  change_date    date/nn   -- last modificationd datetime of record
  message        vc200     -- additional message

