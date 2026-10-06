DECLARE
    v_name VARCHAR2(30); /* ' v_name ' == 디폴트 값인 NULL */
    v_job VARCHAR2(50) NOT NULL := 'Oracle DBA'; /* NOT NULL 존재시, 기본값 할당 필수 */
    v_d CONSTANT DATE DEFAULT SYSDATE; /* CONSTANT ( 상수 ) 선언시, 기본값 할당 필수 */
BEGIN
	dbms_output.put_line('Hellow World1, ' || q'[x]');
	dbms_output.put_line('Tomorrow''s : ' || TO_CHAR(SYSDATE, 'yyyy-mm-dd'));
    
    dbms_output.put_line('My name is ' || v_name);
    dbms_output.put_line('My job is ' || v_job);
    
    v_name := 'Oracle';
    dbms_output.put_line('My name is ' || v_name);
END;
/




SELECT *
FROM HR.EMPLOYEES
WHERE employee_id = :id; /* 선언없이 바로 사용 (*/




DECLARE
    a NUMBER := 0.5; /* 자동 반올림 처리되어 ' 1 ' 출력*/
    b NUMBER(2,1) := 0.7; /* 2자리 + 소수점 1자리까지 출력 == ' .7 ' 출력 */
    c CONSTANT NUMBER := 20; /* CONSTANT 선언시, 초기값 할당 필수 */
BEGIN
    dbms_output.put_line(a);
    a := 200;
    dbms_output.put_line(a || ', ' || b || ', ' || c);
--    c := 10; /* 상수는 재할당 불가로 ERR 발생 */
END;
/




DECLARE
    v_sal NUMBER := 1000;
    v_comm NUMBER := 0.1;
    v_total NUMBER;
BEGIN
    v_total := v_sal * 12 * v_comm;
    dbms_output.put_line(v_total);
END;
/
