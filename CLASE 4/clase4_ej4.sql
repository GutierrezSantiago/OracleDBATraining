CREATE OR REPLACE PROCEDURE PR_INSERTAR_EMPLEADO 
(
    P_EMPLOYEE_ID	NUMBER,
    P_FIRST_NAME	VARCHAR2,
    P_LAST_NAME	VARCHAR2,
    P_EMAIL	VARCHAR2,
    P_PHONE_NUMBER	VARCHAR2,
    P_HIRE_DATE	DATE,
    P_JOB_ID	VARCHAR2,
    P_SALARY	NUMBER,
    P_COMMISSION_PCT	NUMBER,
    P_MANAGER_ID	NUMBER,
    P_DEPARTMENT_ID	NUMBER,
    P_JOB_TITLE VARCHAR2,
    P_ID  OUT NUMBER,
    P_ERROR OUT VARCHAR2
)
AS
BEGIN

    INSERT INTO JOBS (JOB_ID, JOB_TITLE) VALUES (P_JOB_ID, P_JOB_TITLE);
    
    P_ID := 2;
    
    INSERT INTO EMPLOYEES (
        employee_id,
        first_name,
        last_name,
        email,
        phone_number,
        hire_date,
        job_id,
        salary,
        commission_pct,
        manager_id,
        department_id
    ) VALUES (
        P_EMPLOYEE_ID,
        P_FIRST_NAME,
        P_LAST_NAME,
        P_EMAIL,
        P_PHONE_NUMBER,
        P_HIRE_DATE,
        P_JOB_ID,
        P_SALARY,
        P_COMMISSION_PCT,
        P_MANAGER_ID,
        P_DEPARTMENT_ID
    );
    
    P_ID := 1;
    
EXCEPTION WHEN OTHERS THEN
    
    IF (P_ID = 2) THEN
        DBMS_OUTPUT.PUT_LINE('ERROR : EMPLOYEE_ID: ' || P_EMPLOYEE_ID || ' YA EXISTE.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('ERROR : JOB_ID: ' || P_JOB_ID || ' YA EXISTE.');   
    END IF;
    ROLLBACK;
    P_ID := -1;
    P_ERROR := SQLERRM;
    
    
END ;
/
DECLARE
V_ID NUMBER;
V_ERROR VARCHAR2(200);
BEGIN
    PR_INSERTAR_EMPLEADO(266, 'santi', 'gz', 'SANTI', '351', (TO_DATE('2003/05/03', 'yyyy/mm/dd')), 'AD_PRES', 5000, null , 124, 50, 'President', V_ID, V_ERROR);
    DBMS_OUTPUT.PUT_LINE('P_ID: ' || V_ID || ' - ' || V_ERROR);
    PR_INSERTAR_EMPLEADO(100, 'santi', 'gz', 'SANTI2', '351', (TO_DATE('2003/05/03', 'yyyy/mm/dd')), 'IT_QA', 5000, null , 124, 50, 'QA Tester', V_ID, V_ERROR);
    DBMS_OUTPUT.PUT_LINE('P_ID: ' || V_ID || ' - ' || V_ERROR);
    PR_INSERTAR_EMPLEADO(355, 'santi', 'gz', 'SANTI3', '351', (TO_DATE('2003/05/03', 'yyyy/mm/dd')), 'IT_QA', 5000, null , 124, 50, 'QA Tester', V_ID, V_ERROR);
    DBMS_OUTPUT.PUT_LINE('P_ID: ' || V_ID || ' - ' || V_ERROR);
END;