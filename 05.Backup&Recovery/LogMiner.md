# Log Miner
- ```SQL
  alter database add supplemental log data;


  select supplemental_log_data_min from v$database;


  --alter database drop supplemental log data; /* Default (비활성화) */
  ```
  > Log Miner 사용 前 Setting

</br></br></br>
## Step
1. ```SQL
   begin
    dbms_logmnr.add_logfile(logfilename=>'/u01/app/oracle/oradata/ORA19C/redo01.log', options=>dbms_logmnr.new); /* ' .new ' == 분석할 Redo Log File 처음 등록시 */
    dbms_logmnr.add_logfile(logfilename=>'/u01/app/oracle/oradata/ORA19C/redo02.log', options=>dbms_logmnr.addfile); /* ' .addfile ' == 분석할 Redo Log File 추가로 등록시 */
    dbms_logmnr.add_logfile(logfilename=>'/u01/app/oracle/oradata/ORA19C/redo03.log', options=>dbms_logmnr.addfile);
   --    dbms_logmnr.add_logfile(logfilename=>'/u01/app/oracle/fast_recovery_area/ORA19C/archivelog/2026_11_04/o1_mf_1_1_ogoq30wg_.arc', options=>dbms_logmnr.addfile); /* 내용이 동일한 Redo Log File 중복 등록시 ERR */
   end;
   /


   select filename from v$logmnr_logs;
   ```
   > 분석할 Redo Log File 등록
</br>

2. ```SQL
   exec dbms_logmnr.start_logmnr(options=>dbms_logmnr.dict_from_online_catalog);
   ```
</br>

3. ```SQL
   select to_char(timestamp, 'yyyy-mm-dd hh24:mi:ss') time, operation, sql_redo, sql_undo from v$logmnr_contents where seg_owner = 'JAMES';
   ```
   > Log 분석 출력
</br>
4. ```SQL
   exec dbms_logmnr.end_logmnr;
   ```
---
