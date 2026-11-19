SELECT INSTANCE_NAME, STATUS FROM v$instance; /* INSTANCE_NAME == SID(System IDentifier) */
SELECT NAME, OPEN_MODE, LOG_MODE FROM v$database; /* DB 정보 */
SELECT * FROM v$process;
SELECT * FROM v$sga;

SELECT * FROM v$parameter;
SELECT * FROM v$datafile;
SELECT * FROM v$tempfile;
SELECT * FROM v$log;
SELECT * FROM v$logfile;

select * FROM v$session; /* Login 상태 */
