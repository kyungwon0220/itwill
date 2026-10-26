SELECT * FROM v$process WHERE pname IS NOT NULL; /* 현재 동작중인 Background Process 조회 */

SELECT * FROM v$parameter WHERE NAME = 'fast_start_mttr_target';
ALTER SYSTEM SET fast_start_mttr_target = 600 SCOPE = BOTH; /* Instance Recovery 시간이 600초 이상 소요되지 않게, Check Point 발생 */
SHOW PARAMETER fast_start_mttr_target;

SELECT * FROM v$parameter WHERE NAME = 'log_checkpoints_to_alert'; /* ' log_checkpoints_to_alert ' == ' True ' == ' Check Point ' 발생시, Alert Log File 기록 */
SHOW PARAMETER log_checkpoints_to_alert;

ALTER DATABASE BACKUP CONTROLFILE TO TRACE AS '/home/oracle/control.sql'; /* Backup Control File 이용한 Trace File 생성 */

SELECT NAME FROM v$controlfile;
