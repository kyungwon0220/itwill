create tablespace insa_tbs datafile '/u01/app/oracle/oradata/ORA19C/insa_tbs01.dbf' size 10m;

select tablespace_name, file_name from dba_data_files; /* Dictionary 내용 */
--SYSTEM	/u01/app/oracle/oradata/ORA19C/system01.dbf
--SYSAUX	/u01/app/oracle/oradata/ORA19C/sysaux01.dbf
--USERS	/u01/app/oracle/oradata/ORA19C/users01.dbf
--UNDOTBS1	/u01/app/oracle/oradata/ORA19C/undotbs01.dbf
    SYSTEM	/u01/app/oracle/oradata/ORA19C/system01.dbf
    SYSAUX	/u01/app/oracle/oradata/ORA19C/sysaux01.dbf
    INSA_TBS	/u01/app/oracle/oradata/ORA19C/insa_tbs01.dbf
    USERS	/u01/app/oracle/oradata/ORA19C/users01.dbf
    UNDOTBS1	/u01/app/oracle/oradata/ORA19C/undotbs01.dbf

select file#, name, status, checkpoint_change#, scn_to_timestamp(checkpoint_change#) from v$datafile; /* Control File 내용이며, ' scn_to_timestamp ' == DB Open 시점부터 조회 가능 */
--1	/u01/app/oracle/oradata/ORA19C/system01.dbf	    SYSTEM	2307358	26/11/01 06:02:23.000000000
--3	/u01/app/oracle/oradata/ORA19C/sysaux01.dbf	    ONLINE	2307358	26/11/01 06:02:23.000000000
--4	/u01/app/oracle/oradata/ORA19C/undotbs01.dbf	ONLINE	2307358	26/11/01 06:02:23.000000000
--5	/u01/app/oracle/oradata/ORA19C/insa_tbs01.dbf	ONLINE	2308998	26/11/01 06:22:12.000000000
--7	/u01/app/oracle/oradata/ORA19C/users01.dbf	    ONLINE	2307358	26/11/01 06:02:23.000000000
    1	/u01/app/oracle/oradata/ORA19C/system01.dbf	    SYSTEM	2307358	26/11/01 06:02:23.000000000
    3	/u01/app/oracle/oradata/ORA19C/sysaux01.dbf	    ONLINE	2307358	26/11/01 06:02:23.000000000
    4	/u01/app/oracle/oradata/ORA19C/undotbs01.dbf	ONLINE	2307358	26/11/01 06:02:23.000000000
    5	/u01/app/oracle/oradata/ORA19C/insa_tbs01.dbf	RECOVER	2308998	26/11/01 06:22:12.000000000
    7	/u01/app/oracle/oradata/ORA19C/users01.dbf	    ONLINE	2307358	26/11/01 06:02:23.000000000
--1	/u01/app/oracle/oradata/ORA19C/system01.dbf	    SYSTEM	2307358	26/11/01 06:02:23.000000000
--3	/u01/app/oracle/oradata/ORA19C/sysaux01.dbf	    ONLINE	2307358	26/11/01 06:02:23.000000000
--4	/u01/app/oracle/oradata/ORA19C/undotbs01.dbf	ONLINE	2307358	26/11/01 06:02:23.000000000
--5	/u01/app/oracle/oradata/ORA19C/insa_tbs01.dbf	ONLINE	2311217	26/11/01 06:49:34.000000000
--7	/u01/app/oracle/oradata/ORA19C/users01.dbf	    ONLINE	2307358	26/11/01 06:02:23.000000000

select a.group#, a.sequence#, b.member, a.bytes/1024/1024 mb, a.archived, a.status, a.first_change#, a.next_change#
from v$log a, v$logfile b
where a.group# = b.group#; /* 현재 Redo 정보 조회 */
    0	/u01/app/oracle/oradata/ORA19C/redo03.log	200	YES	UNUSED	0	0
    0	/u01/app/oracle/oradata/ORA19C/redo02.log	200	YES	UNUSED	0	0
    1	/u01/app/oracle/oradata/ORA19C/redo01.log	200	NO	CURRENT	2288914	18446744073709551615

create table hr.insa(id number) tablespace insa_tbs;
insert into hr.insa(id) values(2);
select * from hr.insa;
commit;

select f.file_name
from dba_extents e, dba_data_files f
where e.file_id = f.file_id
and e.segment_name = 'INSA' /* 대문자 입력 필수 */
and e.owner = 'HR'; /* 대문자 입력 필수 */
    /u01/app/oracle/oradata/ORA19C/insa_tbs01.dbf

alter database datafile 5 offline drop;
alter database create datafile '/u01/app/oracle/oradata/ORA19C/insa_tbs01.dbf';
recover datafile 5;
alter database datafile 5 online;
drop tablespace insa_tbs including contents and datafiles;
