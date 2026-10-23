select * from v$log_history; /* log switch 발생 시점 조회 */

SELECT a.group#, b.sequence#, a.member, b.members, b.bytes/1024/1024 mb, b.archived, b.status, b.first_change#, b.next_change#
FROM v$logfile a, v$log b
WHERE a.group# = b.group#
ORDER BY 1;

ALTER SYSTEM SWITCH LOGFILE; /* 수동으로, ' Log Switch ' 발생 */

ALTER DATABASE ADD LOGFILE GROUP 2('/u01/app/oracle/oradata/ORA19C/redo02.log',
                                    '/u01/app/oracle/fast_recovery_area/ORA19C/onlinelog/redo02.log') SIZE 200M;

ALTER DATABASE ADD LOGFILE MEMBER '/u01/app/oracle/fast_recovery_area/ORA19C/onlinelog/redo02.log' TO GROUP 2,
                                    '/u01/app/oracle/fast_recovery_area/ORA19C/onlinelog/redo03.log' TO GROUP 3;

ALTER DATABASE CLEAR LOGFILE GROUP 3;
ALTER DATABASE DROP LOGFILE MEMBER 4;
ALTER DATABASE DROP LOGFILE MEMBER '/u01/app/oracle/oradata/ORA19C/redo02.log';

ALTER SYSTEM CHECKPOINT; /* 수동으로, Full Check Point 발생 */

SELECT * FROM v$parameter WHERE NAME = 'fast_start_mttr_target';
SHOW PARAMETER fast_start_mttr_target;

SHOW PARAMETER log_checkpoints_to_alert;

select * from v$process where pname is not null;
