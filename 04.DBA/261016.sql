SELECT * FROM v$controlfile;
SELECT * FROM v$logfile;
SELECT NAME FROM v$datafile;
SELECT NAME FROM v$tempfile;

SHOW PARAMETER SPFILE;

ALTER SYSTEM SET control_files='/home/oracle/Documents/userdata/control01.ctl' SCOPE=SPFILE;
SELECT NAME FROM v$datafile;

ALTER DATABASE RENAME FILE '/u01/app/oracle/oradata/ORA19C/redo01.log' TO '/home/oracle/Documents/userdata/redo01.log';
ALTER DATABASE RENAME FILE '/u01/app/oracle/oradata/ORA19C/redo02.log' TO '/home/oracle/Documents/userdata/redo02.log';
ALTER DATABASE RENAME FILE '/u01/app/oracle/oradata/ORA19C/redo03.log' TO '/home/oracle/Documents/userdata/redo03.log';
ALTER DATABASE RENAME FILE '/u01/app/oracle/oradata/ORA19C/redo04.log' TO '/home/oracle/Documents/userdata/redo04.log';

SELECT MEMBER FROM v$logfile;


SHOW PARAMETER undo_tablespace; /* 초기 파라미터 파일 內 필수 Parameter */
SHOW PARAMETER undo_management; /* VALUE AUTO == 오라클 자동 관리 */
SHOW PARAMETER undo_retention; /* 트랜잭션 종료후 VALUE 값의 초만큼 이전값을 보존 */

SELECT n.usn, n.name, s.extents, s.rssize, s.xacts, s.status
FROM v$rollname n, v$rollstat s
WHERE n.usn = s.usn; /* Undo */

select s.username, s.sid, s.serial#, t.xidusn, t.ubafil, t.ubablk, t.used_ublk
from v$session s, v$transaction t
where s.saddr = t.ses_addr; /* 현재 종료되지 않은, 트랜잭션 정보 조회 */

ALTER SYSTEM KILL SESSION '263, 41580' IMMEDIATE; /* ' SID ' == ' 263 ' && ' SERIAL# ' == ' 41580 ' Session Kill */

ALTER TABLESPACE undotbs1 ADD DATAFILE '/u01/app/oracle/oradata/ORA19C/undotbs04.dbf' SIZE 10M AUTOEXTEND ON;

CREATE UNDO TABLESPACE undo1 datafile '/u01/app/oracle/oradata/ORA19C/undotbs03.dbf' size 10m autoextend on;

ALTER SYSTEM SET undo_tablespace = undotbs1 SCOPE=BOTH; /* 사용하는 Undo File 변경 */

DROP TABLESPACE undo1 INCLUDING CONTENTS AND DATAFILES; /* Undo Segment 모두 OFFLINE 時 Undo Tablespace 삭제 가능 ( 일반 Tablespace 삭제 Command 동일 ) */

SET PAGESIZE 10000; /* PUTTY Program 上 GUI Setting */
