SELECT TABLESPACE_NAME FROM DBA_TABLESPACES;
    SYSTEM
    SYSAUX
    UNDOTBS1
    TEMP
    USERS

select file#, name, status, checkpoint_change#, scn_to_timestamp(checkpoint_change#) from v$datafile; /* Data File 헤더에도, ' checkpoint_change# ' 존재 ( ' scn_to_timestamp ' == DB Open 시점부터 조회 가능 ) */
    /u01/app/oracle/oradata/ORA19C/system01.dbf	    2236840
    /u01/app/oracle/oradata/ORA19C/sysaux01.dbf	    2236840
    /u01/app/oracle/oradata/ORA19C/undotbs01.dbf	2236840
    /u01/app/oracle/oradata/ORA19C/users01.dbf	    2236840
1	/u01/app/oracle/oradata/ORA19C/system01.dbf	    SYSTEM	2288916	26/10/31 22:52:30.000000000
3	/u01/app/oracle/oradata/ORA19C/sysaux01.dbf	    ONLINE	2288916	26/10/31 22:52:30.000000000
4	/u01/app/oracle/oradata/ORA19C/undotbs01.dbf	ONLINE	2288916	26/10/31 22:52:30.000000000
7	/u01/app/oracle/oradata/ORA19C/users01.dbf	    ONLINE	2288916	26/10/31 22:52:30.000000000




select name, log_mode, checkpoint_change#, scn_to_timestamp(checkpoint_change#), current_scn from v$database; /* DB Checkpoint 정보 ( ' scn_to_timestamp ' == DB Open 시점부터 조회 가능 ) */
    ORA19C	NOARCHIVELOG	2236840	26/10/31 04:13:33.000000000	2287827

alter system checkpoint; /* Full Checkpoint 발생 */

select name, log_mode, checkpoint_change#, scn_to_timestamp(checkpoint_change#), current_scn from v$database; /* DB Checkpoint 정보 ( ' scn_to_timestamp ' == DB Open 시점부터 조회 가능 ) */
    ORA19C	NOARCHIVELOG	2288506	26/10/31 22:43:16.000000000	2288507




select a.group#, a.sequence#, b.member, a.bytes/1024/1024 mb, a.archived, a.status, a.first_change#, a.next_change#
from v$log a, v$logfile b
where a.group# = b.group#; /* 현재 Redo 정보 조회 */
    /u01/app/oracle/oradata/ORA19C/redo03.log	200	NO	INACTIVE	2135883	2236839
    /u01/app/oracle/oradata/ORA19C/redo02.log	200	NO	INACTIVE	2016714	2135883
    /u01/app/oracle/oradata/ORA19C/redo01.log	200	NO	CURRENT	    2236839	18446744073709551615




select f.file_name /* 특정 세그먼트가, 어느 Data 파일에 들어있는지 */
from dba_extents e, dba_data_files f
where e.file_id = f.file_id
and e.segment_name = 'EMP' /* 대문자 입력 필수 */
and e.owner = 'HR'; /* 대문자 입력 필수 */
    /u01/app/oracle/oradata/ORA19C/users01.dbf




--select name, log_mode, checkpoint_change#, scn_to_timestamp(checkpoint_change#), current_scn from v$database; /* DB Checkpoint 정보 ( ' scn_to_timestamp ' == DB Open 시점부터 조회 가능 ) */
--    ORA19C	NOARCHIVELOG	2236840	26/10/31 04:13:33.000000000	2287827 /* 일관성 있는 백업 시점 */

select name, log_mode, checkpoint_change#, scn_to_timestamp(checkpoint_change#), current_scn from v$database; /* DB Checkpoint 정보 ( ' scn_to_timestamp ' == DB Open 시점부터 조회 가능 ) */
    ORA19C	NOARCHIVELOG	2293044	26/10/31 22:52:30.000000000	2293856 /* 현재 시점 */

select file#, name, status, checkpoint_change#, scn_to_timestamp(checkpoint_change#) from v$datafile; /* ' scn_to_timestamp ' == DB Open 시점부터 조회 가능 */
1	/u01/app/oracle/oradata/ORA19C/system01.dbf	    SYSTEM	2293044	26/10/31 22:52:30.000000000
3	/u01/app/oracle/oradata/ORA19C/sysaux01.dbf	    ONLINE	2293044	26/10/31 22:52:30.000000000
4	/u01/app/oracle/oradata/ORA19C/undotbs01.dbf	ONLINE	2293044	26/10/31 22:52:30.000000000
7	/u01/app/oracle/oradata/ORA19C/users01.dbf	    ONLINE	2293044	26/10/31 22:52:30.000000000

select a.group#, a.sequence#, b.member, a.bytes/1024/1024 mb, a.archived, a.status, a.first_change#, a.next_change#
from v$log a, v$logfile b
where a.group# = b.group#; /* 현재 Redo 정보 조회 */
    3	6	/u01/app/oracle/oradata/ORA19C/redo03.log	200	NO	INACTIVE	2135883	2236839
    2	5	/u01/app/oracle/oradata/ORA19C/redo02.log	200	NO	INACTIVE	2016714	2135883
    1	7	/u01/app/oracle/oradata/ORA19C/redo01.log	200	NO	CURRENT	    2236839	18446744073709551615 /* 백업 시점 이후부터, 현재 시점까지 존재하는 Redo Log File 존재 */




--[DB 운영중, 하나의 Data File 손상으로, DB Down 時 완전 복구 Scenario Start]
create table hr.emp(id number, name varchar2(30)) tablespace users;
insert into hr.emp(id, name) values(3, 'oracle3');
select * from hr.emp;
commit;
ALTER SYSTEM CHECKPOINT; /* Database Buffer Cache 內 Dirty 버퍼를, Data 파일에 기록하는 유발 ( Data File 손상을 알게되는 시점 ) */

/* DB Open 시도시, ERR 발생하며 Mount 시점까지 Open */

select status from v$instance; /* 현재 DB Open 시점 조회 */
    MOUNTED
    
select * from v$recover_file; /* Recovery 대상 File 조회 */
    7	ONLINE	ONLINE	FILE NOT FOUND	0		0

alter database datafile 7 offline drop;  /* Noarchive Log Mode 時 문법 */

alter database open;

/* Restore 작업 ( 백업본 cp )*/

recover tablespace users;

alter database datafile 7 online;
--[DB 운영중, 하나의 Data File 손상으로, DB Down 時 완전 복구 Scenario End]
