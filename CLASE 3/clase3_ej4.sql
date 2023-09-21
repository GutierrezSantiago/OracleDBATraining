--FUNCTION
CREATE OR REPLACE FUNCTION FC_OBT_NEW_SALARY (
    P_SALARY EMPLOYEES.SALARY%TYPE,
    P_RAISE_PERCENTAGE NUMBER 
) RETURN NUMBER
AS
BEGIN
    RETURN P_SALARY*(1+P_RAISE_PERCENTAGE);
END;
/
--SELECT
SELECT EMPLOYEE_ID, LAST_NAME, FIRST_NAME, SALARY, FC_OBT_NEW_SALARY(SALARY, 0.2) AS NEW_SALARY FROM EMPLOYEES WHERE SALARY<6000;
