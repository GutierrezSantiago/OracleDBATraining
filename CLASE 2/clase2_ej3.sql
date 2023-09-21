SET SERVEROUTPUT ON
DECLARE
    
    V_SAL_MAX EMPLOYEES.SALARY%TYPE;
    V_SAL_MIN EMPLOYEES.SALARY%TYPE;
    V_ID_JOB EMPLOYEES.JOB_ID%TYPE;
    V_JOB_TITLE JOBS.JOB_TITLE%TYPE;

BEGIN
    
    V_SAL_MAX := 0;
    V_SAL_MIN := 50000;
    V_ID_JOB := 0;
    V_JOB_TITLE := '';
    
    FOR V_ROW IN (SELECT J.JOB_ID, J.JOB_TITLE, MAX(E.SALARY) AS MAX, MIN(E.SALARY) AS MIN FROM EMPLOYEES E JOIN JOBS J ON E.JOB_ID=J.JOB_ID group by J.JOB_ID, J.JOB_TITLE) LOOP
        IF V_ROW.MIN > V_SAL_MAX THEN
            V_SAL_MAX := V_ROW.MAX;
            V_SAL_MIN := V_ROW.MIN;
            V_JOB_TITLE := V_ROW.JOB_TITLE;
        END IF;
        
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE ('EL TRABAJO: ' || V_JOB_TITLE || ' TIENE SALARIOS DESDE: $' || V_SAL_MIN || ' HASTA $' || V_SAL_MAX );
END;