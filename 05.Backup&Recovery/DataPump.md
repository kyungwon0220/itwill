### Meta Data
- Oracle Data Dictionary 테이블이 가진 정보로서, 데이터에 대한 세부 정보를 제공
- dmbs_metadata 패키지를 이용하여, Meta Data 추출 가능
  - ```SQL
    select default_tablespace, temporary_tablespace from dba_users where username= 'HR';
    ```
    |DEFAULT_TABLESPACE|TEMPORARY_TABLESPACE|
    :---|:---|
    SYSAUX|TEMP
    - 이와 같은 정보로, DDL 문장 추출 가능
      - ```SQL
        select dbms_metadata.get_ddl('USER','HR') from dual; /* 대소문자 구분 */
        ```
        ```TEXT
        CREATE USER "HR" IDENTIFIED BY VALUES 'S:979234DC0CF340661B65B3AA5C958506F3ABFD7B89303F0A192A1EEA8F2B;T:A3D12D4956AD918E5B3C41F318F59A0109C328DC8C4CDBAEE93E5E328333F61BDD85527D87C35B931806A65610A670DE44A6E782CEE02E53D603F6535F6A1C0FFEDD78EA75F76E7278B0ACA9981C4172'
        DEFAULT TABLESPACE "SYSAUX"
        TEMPORARY TABLESPACE "TEMP"
        ```
        > Meta Data 예제 코드
      - ```SQL
        select 'GRANT ' || PRIVILEGE || ' TO ' || GRANTEE || ';' from dba_sys_privs where grantee = 'HR';
        --GRANT CREATE DATABASE LINK TO HR;
        --GRANT ALTER SESSION TO HR;
        --GRANT CREATE VIEW TO HR;
        --GRANT UNLIMITED TABLESPACE TO HR;
        --GRANT CREATE SESSION TO HR;
        --GRANT CREATE SEQUENCE TO HR;
        --GRANT CREATE SYNONYM TO HR;
        ```
        ```SQL
        select dbms_metadata.get_granted_ddl('SYSTEM_GRANT', 'HR') from dual;
        --"
        --  GRANT CREATE SESSION TO "HR"
        --  GRANT ALTER SESSION TO "HR"
        --  GRANT UNLIMITED TABLESPACE TO "HR"
        --  GRANT CREATE SYNONYM TO "HR"
        --  GRANT CREATE VIEW TO "HR"
        --  GRANT CREATE SEQUENCE TO "HR"
        --  GRANT CREATE DATABASE LINK TO "HR"
        --"
        ```
---
</br></br></br>


### Oracle Data Pump
- 기존 Export, Import 보다 속도가 빠르다
- 웹 기반 구현 가능 ( em )
- dbms_datapump 패키지로 사용 ( expdp, impdp )
  - ```CMD
    expdp system/oracle schemas=hr dumpfile=hr_schema.dmp directory=pump_dir
    ```
    > ' HR ' User Level Export
    - Meta 정보는, 딕셔너리에 존재하므로, Shared Pool 內 Library Cache 공간 부족시 expdp ERR
    - PGA 內 UGA 內 Curcor 영역에서 Dump 생성 작업시, Temporary Tablespace 공간 부족시 ERR
    - ' schemas ' == dump 대상 ( User 名 )
    - ' dumpfile ' == 만들 Dump File 名
    - ' directory ' == Dump File 만들 경로 ( ' create directory ' 지정해둔 경로만 사용 가능 )
  - ```CMD
    expdp system/oracle schemas=hr dumpfile=hr_table.dmp directory=pump_dir include=table
    ```
    - ' include=table ' == 테이블만
  - ```CMD
    expdp system/oracle dumpfile=hr_james_emp_dept_job.dmp directory=pump_dir tables=hr.employees,hr.departments,hr.job_history,james.emp
    ```
    > 특정 유저가 소유한 테이블들만 Export 가능
  - ```CMD
    expdp system/oracle dumpfile=hr_50_stman.dmp directory=pump_dir tables=hr.employees query=hr.employees:\"where department_id\=50 and job_id\=\'ST_MAN\'\"
    ```
    - ' query=hr.employees:\"where department_id\=50 and job_id\=\'ST_MAN\'\" ' == 특정 조건절에 해당하는 결과만, Export 가능 ( ' select * from hr.employees where department_id = 50 and job_id = 'ST_MAN'; ' 실행 결과 )
  - ```CMD
    impdp system/oracle directory=pump_dir dumpfile=hr_schema.dmp tables=hr.emp
    ```
    > 특정 테이블만 Import 가능
    - ' directory ' == Dump File 경로 ( ' create directory ' 지정해둔 경로만 사용 가능 )
    - ' dumpfile ' == Dump File 名
    - ' tables=hr.emp ' == ' HR ' 유저의 ' emp ' 테이블만 Import
  - ```CMD
    impdp system/oracle dumpfile=hr_50_stman.dmp directory=pump_dir remap_table=employees:emp_50_stman content=data_only
    ```
    - ' remap_table=employees:emp_50_stman ' == 원하는 테이블명으로 Import 가능 (Dump 파일에 들어있는 ' employees ' 테이블을, Import 받는이의 ' emp_50_stman ' 테이블에 Import 적재 ( 받는 Table Meta data 정보 불일치시 Import 적재 불가 ERR ))
    - ' content=metadata_only ' == Meta 정보만 Import
    - ' content=data_only ' == Meta 정보는 있으니, Data 파일만 Import ( Table Meta 정보 불일치시 ERR )
  - ```CMD
    impdp system/oracle dumpfile=hr_table.dmp directory=pump_dir tables=hr.emp remap_schema='hr':'james' remap_tablespace='users':'sysaux'
    ```
    > 특정 테이블을, 다른 유저에게 Import 가능
    - ' rema_schema='hr':'james' ' == 기존의 ' hr ' 유저에서, ' james ' 유저에게
    - ' remap_tablespace='users':'sysaux' ' == ' users ' 테이블스페이스에서, ' sysaux ' 테이블스페이스로 변경
  - ```CMD
    impdp system/oracle network_link=win12c_link tables=hr.hob_history exclude=trigger,grant,ref_constraint remap_schema='hr':'james' remap_tablespace='EXAMPLE':'sysaux'
    ```
    - ' network_link ' == DB Link 名
    - ' exclude=trigger ' == Import 제외 대상
    - ' table_exists_action=skip ' == 이미 동일한 테이블명의 Table 존재시, Skip
    - ' table_exists_action=replace ' == 이미 동일한 테이블명의 Table 존재시, Drop 後 새로 생성하여 Import
    - ' table_exists_action=truncate ' == 이미 동일한 테이블명의 Table 존재시, Data 삭제 後 Import
</br></br></br>
#### Step
1. 
```SQL
create or replace directory pump_dir as '/home/oracle/data_pump';
```
</br>

2. ' create directory ' 지정한 Directory 사용 권한 부여
```SQL
grant read, write on directory pump_dir to ;
```
</br>

3. Export ( dmp File 생성 )
```CMD
! expdp system/oracle directory=pump_dir dumpfile=clone_hr_schema.dmp schemas=hr;
```

3.5. 작업중 Shared Memory 부족 ERR 時
- 1. 
  ```SQL
     select owner_name, job_name, operation, job_mode, state from dba_datapump_jobs;
     --SYSTEM	SYS_EXPORT_SCHEMA_01	EXPORT                        	SCHEMA     /* expdp 작업중 중단된 경우 */
     ```
</br>

- 2. 
  ```SQL
  drop table system.SYS_EXPORT_SCHEMA_01 purge;
  ```
  > expdp 수행 時 작업한 ' system/oracle  Owner Table 삭제 예제 코드
</br>

- 3. DB 종료 後 공간 Check 後 pfile 수정
  ```SQL
  shutdown immediate;
  ```
  ```CMD
  free -h
  --              total        used        free      shared  buff/cache   available
  --Mem:           3.8G        738M        748M        1.1G        2.4G        1.9G
  --Swap:          2.0G         12M        2.0G


  vim /home/oracle/clone/initclone.ora
  ```
  ```TEXT
  *.shared_pool_size=300m
  ```
  > pfile 마지막 줄에 추가
</br>

- 3.5. ERR 時 생성된 dmp File 삭제
  ```CMD
  rm /home/oracle/data_pump/clone_hr_schema.dmp
  ```
  > 불필요시, ' export.log ' Log File 삭제
</br>

- 4. pfile 기반으로 startup
  ```SQL
  startup pfile=/home/oracle/backup/clone/initclone.ora


  show parameter shared_pool_size;  
  ```
</br>

4. Import 필요한 Instance SQLPLUS 환경에서 Import
```SQL
! impdp system/oracle directory=pump_dir dumpfile=clone_hr_schema.dmp schemas=hr;
```
</br></br></br>

---
