select rowid, e.* from hr.employees e; /* ROWID */
select * from dba_objects where object_name = 'EMPLOYEES'; /* DATA_OBJECT_ID == 객체 고유 번호 */
select * from dba_tables where table_name = 'EMPLOYEES'; /* ' TABLESPACE_NAME ' == 테이블 스페이스명 */
select * from dba_data_files where tablespace_name = 'SYSAUX'; /* FILE_ID */
select * from dba_extents where segment_name = 'EMPLOYEES'; /* BLOCK_ID */

select * from dba_segments where segment_name = 'EMP_EMP_ID_PK'; /* 인덱스 Segment HEADER_BLOCK 다음 BLOCK == ROOT BLOCK */
select * from dba_extents where segment_name = 'EMP_EMP_ID_PK';

select * from v$sga_dynamic_components; /* sga_target 설정되어있을시 보는 Dictionary View */
