SELECT * FROM dba_tablespaces;

SELECT * FROM v$datafile; /* ' v$* ' == nomount 시점부터 조회 가능 */
SELECT * FROM dba_data_files; /* ' user_* ', ' dba_* ', ' all_* ' 계열 == open 시점 이후부터 열람 가능 ( nomount, mount 시점에서 조회 불가 ) */

SELECT MAX(lebsz) FROM x$kccle;

CREATE TABLESPACE insadata
DATAFILE '/u01/app/oracle/oradata/ORA19C/insa_tbs01.dbf' SIZE 5M;

CREATE TABLESPACE insadata
DATAFILE '/u01/app/oracle/oradata/ORA19C/insa_tbs01.dbf' SIZE 5M AUTOEXTEND ON
EXTENT MANAGEMENT LOCAL UNIFORM; /* Extent 크기 == Default 1M */

SELECT * FROM dba_segments WHERE segment_name = 'EMP';
SELECT * FROM dba_extents WHERE segment_name = 'EMP';



ALTER DATABASE DATAFILE '/u01/app/oracle/oradata/ORA19C/insa_tbs01.dbf' RESIZE 10M; /* 운영중, DATAFILE 크기 수동 설정 가능 */

ALTER DATABASE DATAFILE '/u01/app/oracle/oradata/ORA19C/insa_tbs01.dbf' AUTOEXTEND OFF; /* ' AUTOEXTENSIBLE ' == ' NO ' == Auto 확장 기능 Off */
ALTER DATABASE DATAFILE '/u01/app/oracle/oradata/ORA19C/insa_tbs01.dbf' AUTOEXTEND ON; /* ' AUTOEXTENSIBLE ' == ' YES ' == Auto 확장 기능 On */

ALTER DATABASE DATAFILE '/u01/app/oracle/oradata/ORA19C/insa_tbs01.dbf' AUTOEXTEND ON NEXT 1M MAXSIZE 10M; /* Auto 확장 時 1M 크기로, 최대 10M 크기까지 확장 */
ALTER DATABASE DATAFILE '/u01/app/oracle/oradata/ORA19C/insa_tbs01.dbf' AUTOEXTEND ON NEXT 1M MAXSIZE UNLIMITED; /* Auto 확장 時 1M 크기로 무한개수까지 확장 *

ALTER TABLESPACE insadata ADD DATAFILE '/u01/app/oracle/oradata/ORA19C/insa_tbs02.dbf' 10M; /* Tablespace 內 Data File 추가로 구성 */

ALTER TABLESPACE insadata READ WRITE;
ALTER TABLESPACE insadata READ ONLY;

SELECT d.file_id, d.tablespace_name, d.file_name, v.checkpoint_change#, v.enabled, d.online_status
FROM v$datafile v, dba_data_files d
WHERE v.file# = d.file_id;

SELECT * FROM dba_temp_files;

ALTER TABLE INSA.EMP MODIFY last_name VARCHAR2(50);
--ALTER TABLE INSA.EMP DROP COLUMN dept_name; /* READ ONLY 모드에서 불가 ERR */
ALTER TABLE INSA.EMP ADD dept_name VARCHAR2(30);
--ALTER TABLESPACE temp OFFLINE; /* OFFLINE 처리 불가 ERR */
ALTER TABLESPACE SYSAUX OFFLINE; /* == ' ALTER TABLESPACE SYSAUX OFFLINE NORMAL; '*/
ALTER TABLESPACE SYSAUX ONLINE;

DESC INSA.EMP;
ROLLBACK;

SELECT 'mv -v ' || NAME || ' /home/oracle/Documents/' AS "Command" FROM v$datafile;
SELECT 'ALTER DATABASE RENAME FILE''' || NAME || ''' TO ' || '''/home/oracle/Documents/userdata' || SUBSTR(NAME, INSTR(NAME, '/', -1)) || ''';' FROM v$datafile;

SELECT f.file_name
FROM dba_extents e, dba_data_files f
where e.file_id = f.file_id AND e.segment_name = 'EMP' AND e.owner = 'INSA';

DROP TABLESPACE userdata INCLUDING CONTENTS AND DATAFILES;
