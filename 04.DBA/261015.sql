SELECT * FROM dba_tablespaces;

SELECT * FROM v$datafile;
SELECT * FROM dba_data_files;

SELECT * FROM dba_segments WHERE segment_name = 'EMP';
SELECT * FROM dba_extents WHERE segment_name = 'EMP';

CREATE TABLESPACE insadata
DATAFILE '/u01/app/oracle/oradata/ORA19C/insa_tbs01.dbf' SIZE 5M;
