select sequence#, name, first_change#, to_char(first_time, 'yyyy-mm-dd hh24:mi:ss') first_name, next_change#, to_char(next_time, 'yyyy-mm-dd hh24:mi:ss') next_time
from v$archived_log /* Control 파일이 가지고 있는, Archive 내용의 SCN 정보 */
where next_change# >= 4199492; /* 특정 SCN 이후 생성된 Archive Backup Log File 조회 */

list archivelog from scn 4371519;
--List of Archived Log Copies for database with db_unique_name ORA19C
--=====================================================================
--
--Key     Thrd Seq     S Low Time
--------- ---- ------- - ---------
--12      1    7       A 10-NOV-26
--        Name: /u01/app/oracle/fast_recovery_area/ORA19C/archivelog/2026_11_11/o1_mf_1_7_oh8txohd_.arc

list archivelog from scn 4199492 until scn 4371521; /* 특정 SCN 범위를 포함한 Archive 조회 */
--List of Archived Log Copies for database with db_unique_name ORA19C
--=====================================================================
--
--Key     Thrd Seq     S Low Time
--------- ---- ------- - ---------
--6       1    1       A 10-NOV-26
--        Name: /u01/app/oracle/fast_recovery_area/ORA19C/archivelog/2026_11_10/o1_mf_1_1_oh535bfl_.arc
--
--7       1    2       A 10-NOV-26
--        Name: /u01/app/oracle/fast_recovery_area/ORA19C/archivelog/2026_11_10/o1_mf_1_2_oh53985c_.arc
--
--8       1    3       A 10-NOV-26
--        Name: /u01/app/oracle/fast_recovery_area/ORA19C/archivelog/2026_11_10/o1_mf_1_3_oh5399tk_.arc
--
--9       1    4       A 10-NOV-26
--        Name: /u01/app/oracle/fast_recovery_area/ORA19C/archivelog/2026_11_10/o1_mf_1_4_oh539dxy_.arc
--
--10      1    5       A 10-NOV-26
--        Name: /u01/app/oracle/fast_recovery_area/ORA19C/archivelog/2026_11_10/o1_mf_1_5_oh55twpl_.arc
--
--11      1    6       A 10-NOV-26
--        Name: /u01/app/oracle/fast_recovery_area/ORA19C/archivelog/2026_11_10/o1_mf_1_6_oh5qd3vr_.arc
--
--12      1    7       A 10-NOV-26
--        Name: /u01/app/oracle/fast_recovery_area/ORA19C/archivelog/2026_11_11/o1_mf_1_7_oh8txohd_.arc

select a.file#, b.name tbs_name, a.name file_name, a.checkpoint_change#, a.status
from v$datafile a, v$tablespace b
where a.ts# = b.ts#;
--1	SYSTEM	    /u01/app/oracle/oradata/ORA19C/system01.dbf	    4372674	SYSTEM
--2	DATA_TBS	/u01/app/oracle/oradata/ORA19C/data_tbs01.dbf	4372674	ONLINE
--4	DATA_TBS	/u01/app/oracle/oradata/ORA19C/data_tbs03.dbf	4372674	ONLINE
--3	SYSAUX	    /u01/app/oracle/oradata/ORA19C/sysaux01.dbf	    4372674	ONLINE
--5	UNDO1	    /u01/app/oracle/oradata/ORA19C/undo01.dbf	    4372674	ONLINE
--7	USERS	    /u01/app/oracle/oradata/ORA19C/users01.dbf	    4372674	ONLINE




run {
    set until snc=4371520; /* 사용중이던 Curren Redo Log File 시작 SCN 4371520 이전까지만 복구 범위 지정 */
    restore database;
    recover database;
} /* RMAN 內 Cancel Base Recovery */

alter database open resetlogs;

alter system archive log current;
