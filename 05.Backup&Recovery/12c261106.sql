SELECT * FROM v$version;
--Oracle Database 12c Enterprise Edition Release 12.1.0.2.0 - 64bit Production	0
--PL/SQL Release 12.1.0.2.0 - Production	0
--"CORE	12.1.0.2.0	Production"	0
--TNS for 64-bit Windows: Version 12.1.0.2.0 - Production	0
--NLSRTL Version 12.1.0.2.0 - Production	0

select * from dba_tables where owner='HR';
--HR	COUNTRIES				    VALID	0	    0	0	0									                N	25			0	0	15	0		         1	         1	    N	ENABLED	25	2014/09/11 11:23:43	NO	IOT	N	N	NO	DEFAULT	DEFAULT	DEFAULT	DISABLED	YES	NO		DISABLED	YES		DISABLED	DISABLED	BASIC	NO	NO	YES	DEFAULT	NO			NO	NO	DISABLED				
--HR	JOB_HISTORY	EXAMPLE			VALID	10		    1	255	65536	1048576	1	2147483645				NO	N	10	5	0	0	0	31	0	0	         1	         1	    N	ENABLED	10	2014/09/11 11:23:44	NO		N	N	NO	DEFAULT	DEFAULT	DEFAULT	DISABLED	YES	NO		DISABLED	YES		DISABLED	DISABLED		    NO	NO	YES	DEFAULT	NO			NO	NO	DISABLED				
--HR	EMPLOYEES	EXAMPLE			VALID	10		    1	255	65536	1048576	1	2147483645				NO	N	107	5	0	0	0	81	0	0	         1	         1	    N	ENABLED	107	2026/09/28 00:06:49	NO		N	N	NO	DEFAULT	DEFAULT	DEFAULT	DISABLED	YES	NO		DISABLED	YES		DISABLED	DISABLED		    NO	NO	YES	DEFAULT	NO			NO	NO	DISABLED				
--HR	JOBS	    EXAMPLE			VALID	10		    1	255	65536	1048576	1	2147483645				NO	N	19	5	0	0	0	33	0	0	         1	         1	    N	ENABLED	19	2014/09/11 11:23:43	NO		N	N	NO	DEFAULT	DEFAULT	DEFAULT	DISABLED	YES	NO		DISABLED	YES		DISABLED	DISABLED		    NO	NO	YES	DEFAULT	NO			NO	NO	DISABLED				
--HR	DEPARTMENTS	EXAMPLE			VALID	10		    1	255	65536	1048576	1	2147483645				NO	N	27	5	0	0	0	21	0	0	         1	         1	    N	ENABLED	27	2014/09/11 11:23:43	NO		N	N	NO	DEFAULT	DEFAULT	DEFAULT	DISABLED	YES	NO		DISABLED	YES		DISABLED	DISABLED		    NO	NO	YES	DEFAULT	NO			NO	NO	DISABLED				
--HR	LOCATIONS	EXAMPLE			VALID	10		    1	255	65536	1048576	1	2147483645				NO	N	23	5	0	0	0	49	0	0	         1	         1	    N	ENABLED	23	2014/09/11 11:23:44	NO		N	N	NO	DEFAULT	DEFAULT	DEFAULT	DISABLED	YES	NO		DISABLED	YES		DISABLED	DISABLED		    NO	NO	YES	DEFAULT	NO			NO	NO	DISABLED				
--HR	REGIONS	    EXAMPLE			VALID	10		    1	255	65536	1048576	1	2147483645				NO	N	4	5	0	0	0	14	0	0	         1	         1	    N	ENABLED	4	2014/09/11 11:23:44	NO		N	N	NO	DEFAULT	DEFAULT	DEFAULT	DISABLED	YES	NO		DISABLED	YES		DISABLED	DISABLED		    NO	NO	YES	DEFAULT	NO			NO	NO	DISABLED				




drop directory pump_dir;
create directory pump_dir as 'C:\app\lkw220\product\12.1.0\dbhome_1\data_pump';
select * from dba_directories;
grant read, write on directory pump_dir to hr;

select count(*) from hr.job_history;
--expdp hr/hr directory=pump_dir dumpfile=12c_hr_job_history.dmp tables=hr.job_history /* OS 上 Export Command */
--scp C:\app\lkw220\product\12.1.0\dbhome_1\data_pump/12C_HR_JOB_HISTORY.DMP oracle@192.168.56.110:/home/oracle/data_pump /* OS 上 Export Command */
