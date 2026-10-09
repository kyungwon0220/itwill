--[문제] 1~10까지 출력하는 프로그램을 작성해주세요. (4, 8 번은 제외)
DECLARE
    cnt NUMBER := 1;
BEGIN
    LOOP
        IF cnt != 4 AND cnt != 8 THEN
            DBMS_OUTPUT.PUT_LINE(cnt);
        END IF;
        
        
        cnt := cnt + 1;
        
        
        EXIT WHEN cnt > 10; /* ' cnt > 10 ' 조건 성립시, ' END LOOP; ' */
    END LOOP;
END;
/


--[문제] 1 ~ 10까지 합을 출력해주세요
DECLARE
    x NUMBER := 1;
    hap NUMBER := 0;
BEGIN
    LOOP
        hap := hap + x;
        x := x + 1;


        EXIT WHEN x > 10;
    END LOOP;
    
    
    DBMS_OUTPUT.PUT_LINE(hap);
END;
/


--[문제] 2단 ~ 9단 출력
DECLARE
    x NUMBER := 2;
    y NUMBER;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(x || ' 단 ');
        
        y := 1;
        
        
        LOOP
            DBMS_OUTPUT.PUT_LINE(x || ' * ' || y || ' = ' || x * y);
            
            
            y := y + 1;
            
            
            EXIT WHEN y = 10;
        END LOOP;


        x := x + 1;
        
        
        EXIT WHEN x = 10;
    END LOOP;
END;
/
