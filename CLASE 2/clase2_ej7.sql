SET SERVEROUTPUT ON
BEGIN
    FOR V_ROW IN(SELECT JOB_ID, MIN(SALARY) AS MINIMO FROM EMPLOYEES GROUP BY JOB_ID)LOOP
        IF V_ROW.MINIMO<4200 THEN
            DBMS_OUTPUT.PUT_LINE('EL SALARIO MINIMO DEL TRABAJO: '|| V_ROW.JOB_ID ||' ES MENOR A 4200');
        ELSIF V_ROW.MINIMO < 9000 THEN
            DBMS_OUTPUT.PUT_LINE('EL SALARIO MINIMO DEL TRABAJO: '|| V_ROW.JOB_ID ||' ESTA ENTRE 4200 Y 9000');
        ELSE 
            DBMS_OUTPUT.PUT_LINE('EL SALARIO MINIMO DEL TRABAJO: '|| V_ROW.JOB_ID ||' ES MAYOR A 9000');
        END IF;
    END LOOP;
END;
