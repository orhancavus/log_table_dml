-- Author         : Orhan Çavuş
-- Last Modified  : 10.20.202

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

/*
begin
    pkg_log_dml.log_table_dml(ptable_name => 'USERS', ptable_pk => '23232' ,  pdml_type => 'I', pchange_date => sysdate, pmessage => 'no message');
    commit;
end;
*/

