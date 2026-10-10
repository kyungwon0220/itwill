<<OUTER>> /* ' OUTER ' Label ( 레이블 ) */
DECLARE
  x NUMBER := 10;
BEGIN


  <<INNER>> /* ' INNER ' Label ( 레이블 ) */
  DECLARE
  x NUMBER := 20;
  BEGIN
    DBMS_OUTPUT.PUT_LINE(OUTER.x); /* ' OUTER ' 레이블의 x 값인 ' 10 ' 출력 */
  END;
  
  
--  DBMS_OUTPUT.PUT_LINE(INNER.x); /* 바깥쪽 블록에서, 안쪽 블록 레이블의 변수 사용 불가 ERR */
END;
/




DECLARE
    flag BOOLEAN; /* 기본값 NULL*/
BEGIN
    IF flag THEN
        DBMS_OUTPUT.PUT_LINE('TRUE!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('FALSE!'); /* NULL == FALSE 성립되어, ' FALSE! ' 출력 */
    END IF;
    
    
    IF flag IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('NOT NULL!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('NULL!');
    END IF;
END;
/




DECLARE
    ch1 CHAR(1) := 'F';
    ch2 CHAR(1) := :bind_ch1;
    str1 VARCHAR2(50);
BEGIN
    str1 := CASE ch1
                WHEN 'A' THEN 'A!'
                WHEN 'B' THEN 'B!'
                ELSE 'F!' /* NULL 값 또한, ELSE */
            END;
            
            
    DBMS_OUTPUT.PUT_LINE(str1);
    
    
    
    
    str1 := CASE ch2
                WHEN 'A' THEN 'A!'
                WHEN 'B' THEN 'B!'
                ELSE 'F!' /* NULL 값 또한, ELSE */
            END;
            
            
    DBMS_OUTPUT.PUT_LINE(str1);        
END;
/




DECLARE
    cnt NUMBER := 0;
BEGIN
    LOOP
        cnt := cnt + 1;
        
        
        CONTINUE WHEN MOD(cnt, 2) = 0; /* ' MOD(cnt, 2) = 0 ' 조건 성립시, 다음 반복으로 ( 현재 반복 Skip ) */


        EXIT WHEN cnt > 10;
        
        
        DBMS_OUTPUT.PUT_LINE(cnt);
    END LOOP;
END;
/
