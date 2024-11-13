start C:\Users\ASUS\Documents\GitHub\scriptsBDOO\creacion.sql
start C:\Users\ASUS\Documents\GitHub\scriptsBDOO\inserts.sql
start C:\Users\ASUS\Documents\GitHub\scriptsBDOO\packages.sql
start C:\Users\ASUS\Documents\GitHub\scriptsBDOO\trigger.sql

/*TABLESPACE

connect system/1234

show con_name

ALTER SESSION SET CONTAINER=CDB$ROOT;
ALTER DATABASE OPEN;

DROP TABLESPACE ts_bdObjectual INCLUDING CONTENTS and DATAFILES;
    
CREATE TABLESPACE ts_bdObjectual LOGGING
DATAFILE 'C:\Users\ASUS\Desktop\BDFinal\DF_DBOBJECTUAL.dbf' size 500M
extent management local segment space management auto;
 
alter session set "_ORACLE_SCRIPT"=true;
 
drop user us_bdObjectual cascade;
    
CREATE user us_bdObjectual profile default
identified by 1234
default tablespace ts_bdObjectual
temporary tablespace temp
account unlock;	 

--privilegios
grant connect, resource,dba to us_bdObjectual;

connect us_bdObjectual/1234

show user

*/