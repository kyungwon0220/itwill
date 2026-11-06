alter system archive log current;

select a.group#, a.sequence#, b.member, a.bytes/1024/1024 mb, a.members, a.archived, a.status, a.first_change#, to_char(first_time,'yyyy-mm-dd hh24:mi:ss') first_time, a.next_change#, to_char(next_time, 'yyyy-mm-dd hh24:mi:ss') next_time
from v$log a, v$logfile b
where a.group# = b.group#; /* 현재 Redo 정보 조회 */
--2	2	/u01/app/oracle/oradata/ORA19C/redo02.log	200	1	YES	INACTIVE	2509329	2026-11-05 18:13:23	2509357	                2026-11-05 18:14:26
--1	4	/u01/app/oracle/oradata/ORA19C/redo01.log	200	1	NO	CURRENT	    2539459	2026-11-05 23:33:08	18446744073709551615	
--3	3	/u01/app/oracle/oradata/ORA19C/redo03.log	200	1	YES	ACTIVE	    2509357	2026-11-05 18:14:26	2539459	                2026-11-05 23:33:08




*.compatible='19.0.0'
*.control_files='/home/oracle/backup/clone/control01.ctl'
*.db_name='clone'
*.log_archive_dest_2='location=/home/oracle/backup/clone/ mandatory'
*.log_archive_format='arch_%t_%s_%r.arc'
*.undo_tablespace='UNDO1'




--orapwd file=orapwclone password=oracle format=12 /* OS 內 ' $ORACLE_HOME/dbs ' 경로에 oracle ' PW, 인증 추가 */
