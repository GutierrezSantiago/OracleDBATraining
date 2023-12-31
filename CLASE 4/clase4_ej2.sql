CREATE OR REPLACE PROCEDURE PR_ACTUALIZAR_TRABAJO (P_JOB_ID IN VARCHAR2, P_JOB_TITLE IN VARCHAR2, P_MIN_SALARY IN NUMBER, P_MAX_SALARY IN NUMBER, P_ID OUT NUMBER, P_ERROR OUT VARCHAR2)
AS
V_JOB_COUNT NUMBER;
BEGIN

SELECT COUNT(1) INTO  V_JOB_COUNT FROM JOBS WHERE JOB_ID=P_JOB_ID;

IF V_JOB_COUNT = 0 THEN
    RAISE_APPLICATION_ERROR(-20549, 'NO HAY NINGUN JOB BAJO ESE ID');
END IF;

UPDATE JOBS 
    
    SET
        JOB_TITLE = P_JOB_TITLE,
        MAX_SALARY = P_MAX_SALARY,
        MIN_SALARY = P_MIN_SALARY
    WHERE JOB_ID=P_JOB_ID;
    
    P_ID := 1;
EXCEPTION
    WHEN OTHERS THEN
        P_ID := -1;
        P_ERROR := SQLERRM;
        
END PR_ACTUALIZAR_TRABAJO;
/
SELECT * FROM JOBS WHERE JOB_ID='IT_PROG';
SELECT * FROM JOBS WHERE JOB_ID='IT_QA';
/
DECLARE
V_ID NUMBER;
V_ERROR VARCHAR2(100);
BEGIN
PR_ACTUALIZAR_TRABAJO('IT_PROG', 'IT Programmer', 6000, 12000, V_ID, V_ERROR);
DBMS_OUTPUT.PUT_LINE(V_ERROR || ' P_ID: ' || V_ID);
PR_ACTUALIZAR_TRABAJO('IT_QA', 'QA Testing', 4000, 10000, V_ID, V_ERROR);
DBMS_OUTPUT.PUT_LINE(V_ERROR || ' P_ID: ' || V_ID);
END;
/
SELECT * FROM JOBS WHERE JOB_ID='IT_PROG';
SELECT * FROM JOBS WHERE JOB_ID='IT_QA';