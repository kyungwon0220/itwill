alter database disable block change tracking;
alter database enable block change tracking using file '/home/oracle/backup/rman/ora19c_block_tracking.txt';

select filename, bytes, status from v$block_change_tracking;
--		DISABLED
    /home/oracle/backup/rman/ora19c_block_tracking.txt	11599872	ENABLED




backup incremental level 1 database;

select file#, incremental_level, blocks, datafile_blocks, used_change_tracking from v$backup_datafile;




run {
    allocate channel ch1 device type disk format "/home/oracle/backup/rman/inc/%U";
    backup as copy tag 'base01' incremental level 0 database;
    backup as copy current controlfile;
}

insert into james.emp select * from james.emp;
select count(*) from james.emp;

run {
    allocate channel ch1 device type disk format "/home/oracle/backup/rman/inc/%U";
    backup incremental level 1 database tag 'incremental_update';
    backup as copy current controlfile;
}

run {
    allocate channel ch1 device type disk format "/home/oracle/backup/rman/inc/%U";
    recover copy of database with tag 'base01';
}




backup format '/home/oracle/backup/rman/rcdb/%U_%T' database include current controlfile;

alter system archive log current;

--rman auxiliary /

run {
    duplicate target database to 'rcdb'
    pfile='/u01/app/oracle/product/19.3.0/dbhome_1/dbs/initrcdb.ora'
    nofilenamecheck
    backup location '/home/oracle/backup/rman/rcdb'
}

select dbid, name, log_mode from v$database;
--2105980133 RCDB      ARCHIVELOG




create tablespace rc_tbs datafile '/home/oracle/backup/rman/rcdb/rc_tbs01.dbf' size 10m autoextend on;

select file_id, tablespace_name, file_name, bytes/1024/1024 mb, autoextensible from dba_data_files;

create user rc_user
identified by oracle
default tablespace rc_tbs
temporary tablespace temp
quota unlimited on rc_tbs;

grant connect, resource, recovery_catalog_owner to rc_user;




--rman target / catalog rc_user/oracle@rcdb;

--register database;
