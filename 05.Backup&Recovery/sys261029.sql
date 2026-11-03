create table hr.new(id number) tablespace users;
insert into hr.new(id) values(3);
select * from hr.new;

/* Undo File 손상 ( rm ) */

alter system switch logfile;
alter system switch logfile;
alter system switch logfile; /* ERR 발생하며, DB Down */

startup; /* ERR 발생하며 Mount 시점까지 Open */
alter database datafile 4 offline drop; /* Mount 시점에서, 문제의 Undo Data File Offline */
alter database open;

create undo tablespace undo1 datafile '/u01/app/oracle/oradata/ORA19C/undo01.dbf' size 10M autoextend on; /* 새로운 Undo Tablespace 생성 */
alter system set undo_tablespace = undo1 scope = both; /* undo1 Tablespace 사용 지정 */
show parameter undo_tablespace;

select employee_id, salary from hr.employees where employee_id = 200;
--200	4400
    200	4840
update hr.employees set salary = salary * 1.1 where employee_id = 200;
rollback;

SELECT n.usn, n.name, s.extents, s.rssize, s.xacts, s.status
FROM v$rollname n, v$rollstat s
WHERE n.usn = s.usn; /* Undo */
--0	SYSTEM	                7	450560	    0	ONLINE
--1	_SYSSMU1_1261223759$	37	23060480	0	ONLINE
--2	_SYSSMU2_27624015$	    53	39837696	0	ONLINE
--3	_SYSSMU3_2421748942$	48	34594816	0	ONLINE
--4	_SYSSMU4_625702278$	    41	27254784	0	ONLINE
--5	_SYSSMU5_2101348960$	53	39837696	0	ONLINE
--6	_SYSSMU6_813816332$	    40	26206208	0	ONLINE
--7	_SYSSMU7_2329891355$	81	78635008	0	ONLINE
--8	_SYSSMU8_399776867$	    49	35643392	0	ONLINE
--9	_SYSSMU9_1692468413$	49	35643392	0	ONLINE
--10_SYSSMU10_930580995$	34	19914752	0	ONLINE
    0	SYSTEM	                7	450560	    0	ONLINE
    1	_SYSSMU1_1261223759$	5	3268608	    0	ONLINE
    2	_SYSSMU2_27624015$	    5	3268608	    0	ONLINE
    3	_SYSSMU3_2421748942$	3	1171456	    1 /* Transaction 사용중인 Undo */	ONLINE
    4	_SYSSMU4_625702278$	    41	27254784	0	ONLINE
    5	_SYSSMU5_2101348960$	4	2220032	    0	ONLINE
    6	_SYSSMU6_813816332$	    5	3268608	    0	ONLINE
    7	_SYSSMU7_2329891355$	81	78635008	0	ONLINE
    8	_SYSSMU8_399776867$	    5	3268608	    0	ONLINE
    9	_SYSSMU9_1692468413$	5	3268608	    0	ONLINE
    10	_SYSSMU10_930580995$	34	19914752	0	ONLINE
--0	SYSTEM	7	450560	0	ONLINE /* System ' XACTS ' ==  Transaction 진행중이나, ' 0 ' 표기 */
    0	SYSTEM	8	516096	0	ONLINE
    11	_SYSSMU11_3712128196$	2	122880	0	ONLINE
    12	_SYSSMU12_4235515065$	2	122880	0	ONLINE
    13	_SYSSMU13_1426761871$	2	122880	0	ONLINE
    14	_SYSSMU14_777126725$	2	122880	0	ONLINE
    15	_SYSSMU15_1466344224$	2	122880	0	ONLINE
    16	_SYSSMU16_785811169$	2	122880	0	ONLINE
    17	_SYSSMU17_2030247083$	2	122880	0	ONLINE
    18	_SYSSMU18_3436562894$	2	122880	0	ONLINE
    19	_SYSSMU19_2435865630$	2	122880	0	ONLINE
    20	_SYSSMU20_2067323191$	2	122880	0	ONLINE

select s.username, s.sid, s.serial#, t.xidusn, t.ubafil, t.ubablk, t.used_ublk
from v$session s, v$transaction t
where s.saddr = t.ses_addr; /* 현재 종료되지 않은, Transaction 정보 조회 */
--SYS	273	818	3	4	5009	1
    SYS	34	33570	0	1	542	1 /* Public Undo 사용 불가시, System Undo 사용 */

select segment_id,segment_name, owner, tablespace_name, status from dba_rollback_segs; /* Undo Segment 정보 */
--0	SYSTEM	                SYS	    SYSTEM	    ONLINE
--1	_SYSSMU1_1261223759$	PUBLIC	UNDOTBS1	ONLINE
--2	_SYSSMU2_27624015$	    PUBLIC	UNDOTBS1	ONLINE
--3	_SYSSMU3_2421748942$	PUBLIC	UNDOTBS1	ONLINE
--4	_SYSSMU4_625702278$	    PUBLIC	UNDOTBS1	ONLINE
--5	_SYSSMU5_2101348960$	PUBLIC	UNDOTBS1	ONLINE
--6	_SYSSMU6_813816332$	    PUBLIC	UNDOTBS1	ONLINE
--7	_SYSSMU7_2329891355$	PUBLIC	UNDOTBS1	ONLINE
--8	_SYSSMU8_399776867$	    PUBLIC	UNDOTBS1	ONLINE
--9	_SYSSMU9_1692468413$	PUBLIC	UNDOTBS1	ONLINE
--10	_SYSSMU10_930580995$	PUBLIC	UNDOTBS1	ONLINE
    0	SYSTEM	                SYS	    SYSTEM	    ONLINE
    1	_SYSSMU1_1261223759$	PUBLIC	UNDOTBS1	NEEDS RECOVERY
    2	_SYSSMU2_27624015$	    PUBLIC	UNDOTBS1	NEEDS RECOVERY
    3	_SYSSMU3_2421748942$	PUBLIC	UNDOTBS1	NEEDS RECOVERY
    4	_SYSSMU4_625702278$	    PUBLIC	UNDOTBS1	NEEDS RECOVERY
    5	_SYSSMU5_2101348960$	PUBLIC	UNDOTBS1	NEEDS RECOVERY
    6	_SYSSMU6_813816332$	    PUBLIC	UNDOTBS1	NEEDS RECOVERY
    7	_SYSSMU7_2329891355$	PUBLIC	UNDOTBS1	NEEDS RECOVERY
    8	_SYSSMU8_399776867$	    PUBLIC	UNDOTBS1	NEEDS RECOVERY
    9	_SYSSMU9_1692468413$	PUBLIC	UNDOTBS1	NEEDS RECOVERY
    10	_SYSSMU10_930580995$	PUBLIC	UNDOTBS1	NEEDS RECOVERY
--0	    SYSTEM	                SYS	    SYSTEM	    ONLINE
--1	    _SYSSMU1_1261223759$	PUBLIC	UNDOTBS1	NEEDS RECOVERY
--2	    _SYSSMU2_27624015$	    PUBLIC	UNDOTBS1	NEEDS RECOVERY
--3	    _SYSSMU3_2421748942$	PUBLIC	UNDOTBS1	NEEDS RECOVERY
--4	    _SYSSMU4_625702278$	    PUBLIC	UNDOTBS1	NEEDS RECOVERY
--5	    _SYSSMU5_2101348960$	PUBLIC	UNDOTBS1	NEEDS RECOVERY
--6	    _SYSSMU6_813816332$	    PUBLIC	UNDOTBS1	NEEDS RECOVERY
--7	    _SYSSMU7_2329891355$	PUBLIC	UNDOTBS1	NEEDS RECOVERY
--8	    _SYSSMU8_399776867$	    PUBLIC	UNDOTBS1	NEEDS RECOVERY
--9	    _SYSSMU9_1692468413$	PUBLIC	UNDOTBS1	NEEDS RECOVERY
--10	_SYSSMU10_930580995$	PUBLIC	UNDOTBS1	NEEDS RECOVERY
--11	_SYSSMU11_3712128196$	PUBLIC	UNDO1	    ONLINE
--12	_SYSSMU12_4235515065$	PUBLIC	UNDO1	    ONLINE
--13	_SYSSMU13_1426761871$	PUBLIC	UNDO1	    ONLINE
--14	_SYSSMU14_777126725$	PUBLIC	UNDO1	    ONLINE
--15	_SYSSMU15_1466344224$	PUBLIC	UNDO1	    ONLINE
--16	_SYSSMU16_785811169$	PUBLIC	UNDO1	    ONLINE
--17	_SYSSMU17_2030247083$	PUBLIC	UNDO1	    ONLINE
--18	_SYSSMU18_3436562894$	PUBLIC	UNDO1	    ONLINE
--19	_SYSSMU19_2435865630$	PUBLIC	UNDO1	    ONLINE
--20	_SYSSMU20_2067323191$	PUBLIC	UNDO1	    ONLINE

select a.file#, b.name tbs_name, a.name file_name, a.checkpoint_change#, a.status
from v$datafile a, v$tablespace b
where a.ts# = b.ts#; /* Control 파일이 갖고있는, Data File 정보 */
--3	SYSAUX	    /u01/app/oracle/oradata/ORA19C/sysaux01.dbf	    2307358	ONLINE
--1	SYSTEM	    /u01/app/oracle/oradata/ORA19C/system01.dbf	    2307358	SYSTEM
--4	UNDOTBS1	/u01/app/oracle/oradata/ORA19C/undotbs01.dbf	2307358	ONLINE
--7	USERS	    /u01/app/oracle/oradata/ORA19C/users01.dbf	    2307358	ONLINE
    3	SYSAUX	    /u01/app/oracle/oradata/ORA19C/sysaux01.dbf	    2427129	ONLINE
    1	SYSTEM	    /u01/app/oracle/oradata/ORA19C/system01.dbf	    2427129	SYSTEM
    4	UNDOTBS1	/u01/app/oracle/oradata/ORA19C/undotbs01.dbf	2307358	RECOVER
    7	USERS	    /u01/app/oracle/oradata/ORA19C/users01.dbf	    2427129	ONLINE
--3	SYSAUX	/u01/app/oracle/oradata/ORA19C/sysaux01.dbf	2427129	ONLINE
--1	SYSTEM	/u01/app/oracle/oradata/ORA19C/system01.dbf	2427129	SYSTEM
--4	UNDOTBS1	/u01/app/oracle/oradata/ORA19C/undotbs01.dbf	2307358	RECOVER
--7	USERS	/u01/app/oracle/oradata/ORA19C/users01.dbf	2427129	ONLINE
--5	UNDO1	/u01/app/oracle/oradata/ORA19C/undo01.dbf	2429199	ONLINE




select segment_name || ',' from dba_rollback_segs where status = 'NEEDS RECOVERY';
    _SYSSMU1_1261223759$,
    _SYSSMU2_27624015$,
    _SYSSMU3_2421748942$,
    _SYSSMU4_625702278$,
    _SYSSMU5_2101348960$,
    _SYSSMU6_813816332$,
    _SYSSMU7_2329891355$,
    _SYSSMU8_399776867$,
    _SYSSMU9_1692468413$,
    _SYSSMU10_930580995$,




select name, log_mode from v$database;
archive log list;
show parameter log_archive_dest_1;

select * from v$database_incarnation;
    1	1	    2019/04/17 00:55:59	0		                    PARENT	1005785759	0	NO	0
    2	1920977	2026/10/31 04:08:19	1	    2019/04/17 00:55:59	PARENT	1248062899	1	NO	0
    3	2288914	2026/11/01 03:51:00	1920977	2026/10/31 04:08:19	CURRENT	1248148260	2	NO	0

alter system set log_archive_dest_1="location=/home/oracle/backup/arch1/ mandatory" scope = spfile;
alter system set log_archive_dest_2="location=/home/oracle/backup/arch2/ optional" scope = spfile;

show parameter log_archive_format;
alter system set log_archive_format = 'arch_%t_%s_%r.arc' scope = spfile; /* Archive Log File 名 Format 재설정 */

alter database archivelog;
alter database open;

select a.file#, a.name, a.checkpoint_change#, b.status, b.change#, to_char(b.time, 'yyyy-mm-dd hh24:mi:ss') backup_time
from v$datafile a, v$backup b /* ' v$backup ' == Archive Mode View */
where a.file# = b.file#;
--1	/u01/app/oracle/oradata/ORA19C/system01.dbf	2441451	NOT ACTIVE	0	
--3	/u01/app/oracle/oradata/ORA19C/sysaux01.dbf	2441451	NOT ACTIVE	0	
--5	/u01/app/oracle/oradata/ORA19C/undo01.dbf	2441451	NOT ACTIVE	0	
--7	/u01/app/oracle/oradata/ORA19C/users01.dbf	2441451	NOT ACTIVE	0
    1	/u01/app/oracle/oradata/ORA19C/system01.dbf	2442594	ACTIVE	2442594	2026/11/01 15:21:50
    3	/u01/app/oracle/oradata/ORA19C/sysaux01.dbf	2442594	ACTIVE	2442594	2026/11/01 15:21:50
    5	/u01/app/oracle/oradata/ORA19C/undo01.dbf	2442594	ACTIVE	2442594	2026/11/01 15:21:50
    7	/u01/app/oracle/oradata/ORA19C/users01.dbf	2442594	ACTIVE	2442594	2026/11/01 15:21:50
--1	/u01/app/oracle/oradata/ORA19C/system01.dbf	2442594	NOT ACTIVE	2442594	2026-11-01 15:21:50
--3	/u01/app/oracle/oradata/ORA19C/sysaux01.dbf	2442594	NOT ACTIVE	2442594	2026-11-01 15:21:50
--5	/u01/app/oracle/oradata/ORA19C/undo01.dbf	2442594	NOT ACTIVE	2442594	2026-11-01 15:21:50
--7	/u01/app/oracle/oradata/ORA19C/users01.dbf	2442594	NOT ACTIVE	2442594	2026-11-01 15:21:50

alter database begin backup; /* DB Level Online Backup 시작 ( Full Checkpoint 발생 ) */

/* OS 內 dbf File Backup ( cp ) */

alter database end backup;

alter database backup controlfile to '/home/oracle/backup/arch/open/control01.ctl';
alter database backup controlfile to trace as '/home/oracle/backup/arch/open/create_control.txt';




alter system archive log current; /* CURRENT Group Redo Log File Archive */
alter system switch logfile;

select a.group#, a.sequence#, b.member, a.bytes/1024/1024 mb, a.archived, a.status, a.first_change#, a.next_change#
from v$log a, v$logfile b
where a.group# = b.group#; /* 현재 Redo 정보 조회 */
--3	3	/u01/app/oracle/oradata/ORA19C/redo03.log	200	YES	INACTIVE	2327084	2427128
--2	2	/u01/app/oracle/oradata/ORA19C/redo02.log	200	YES	INACTIVE	2326983	2327084
--1	4	/u01/app/oracle/oradata/ORA19C/redo01.log	200	NO	CURRENT	    2427128	18446744073709551615 /* Online 백업시 (2442594) */
    /u01/app/oracle/oradata/ORA19C/redo03.log	200	YES	INACTIVE	2327084	2427128
    /u01/app/oracle/oradata/ORA19C/redo02.log	200	NO	CURRENT	    2444031	18446744073709551615
    /u01/app/oracle/oradata/ORA19C/redo01.log	200	YES	/* Archive 받았을시 ' YES ' */ ACTIVE	    2427128	2444031
--3	6	/u01/app/oracle/oradata/ORA19C/redo03.log	200	YES	ACTIVE	    2444472	2444627
--2	5	/u01/app/oracle/oradata/ORA19C/redo02.log	200	YES	INACTIVE	2444031	2444472
--1	7	/u01/app/oracle/oradata/ORA19C/redo01.log	200	NO	CURRENT	    2444627	18446744073709551615

select sequence#, name, first_change#, next_change# from v$archived_log; /* Control 파일이 가지고 있는, Archive 내용의 SCN 정보 */
    4	/home/oracle/backup/arch1/1_4_1248148260.dbf	2427128	2444031 /* Online 백업시 (2442594) */
    4	/home/oracle/backup/arch2/1_4_1248148260.dbf	2427128	2444031 /* Online 백업시 (2442594) */
    5	/home/oracle/backup/arch1/1_5_1248148260.dbf	2444031	2444472
    5	/home/oracle/backup/arch2/1_5_1248148260.dbf	2444031	2444472




/* OS 內 /u01/app/oracle/oradata/ORA19C/users01.dbf 손상 ( rm ) */

select f.file_name
from dba_extents e, dba_data_files f
where e.file_id = f.file_id
and e.segment_name = 'NEW' /* 대문자 입력 필수 */
and e.owner = 'HR'; /* 대문자 입력 필수 */
    /u01/app/oracle/oradata/ORA19C/users01.dbf

select * from v$recover_file;

alter tablespace users offline immediate; /* Archive Log Mode 時 문법 */

recover tablespace users; /* ' auto ' */

alter tablespace users online;
