DECLARE
    v_name VARCHAR2(30); /* ' v_name ' == 디폴트 값인 NULL */
    v_job VARCHAR2(50) NOT NULL := 'Oracle DBA'; /* NOT NULL 존재시, 기본값 할당 필수 */
    v_d CONSTANT DATE DEFAULT SYSDATE; /* CONSTANT ( 상수 ) 선언시, 기본값 할당 필수 */
BEGIN
	DBMS_OUTPUT.PUT_LINE('Hellow World1, ' || q'[x]');
	DBMS_OUTPUT.PUT_LINE('Tomorrow''s : ' || TO_CHAR(SYSDATE, 'yyyy-mm-dd'));
    
    DBMS_OUTPUT.PUT_LINE('My name is ' || v_name);
    DBMS_OUTPUT.PUT_LINE('My job is ' || v_job);
    
    v_name := 'Oracle'; /* ' v_name ' 변수에, 값을 재할당 */
    DBMS_OUTPUT.PUT_LINE('My name is ' || v_name);
END;
/


DECLARE
    a NUMBER := 0.5; /* 자동 반올림 처리되어 ' 1 ' 출력*/
    b NUMBER(2,1) := 0.7; /* 2자리 + 소수점 1자리까지 출력 == ' .7 ' 출력 */
    c CONSTANT NUMBER := 20; /* CONSTANT ( 상수 ) 선언시, 기본값 할당 필수 */
BEGIN
    DBMS_OUTPUT.PUT_LINE(a);
    a := 200;
    DBMS_OUTPUT.PUT_LINE(a || ', ' || b || ', ' || c);
--    c := 10; /* 상수는 재할당 불가로 ERR 발생 */
END;
/


DECLARE
    v_sal NUMBER := 1000;
    v_comm NUMBER := 0.1;
    v_total NUMBER;
BEGIN
    v_total := v_sal * 12 * v_comm;
    DBMS_OUTPUT.PUT_LINE(v_total);
END;
/




SELECT *
FROM HR.EMPLOYEES
WHERE employee_id = :id; /* SQL Developer 프로그램에서는, 바인드 변수 선언이 따로 불필요 */


SELECT *
FROM HR.EMPLOYEES
WHERE hire_date BETWEEN :a_date AND :b_date
ORDER BY hire_date DESC; /* SQL Developer 프로그램에서는, 바인드 변수 선언이 따로 불필요 */
