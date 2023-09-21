SET SERVEROUTPUT ON
DECLARE
    V_SALARY EMPLOYEES.SALARY%TYPE;
    V_ROW_EMPLOYEE EMPLOYEES%ROWTYPE;
    V_COUNT_ROW NUMBER;
    V_SQLCODE NUMBER;
    V_SQLERRM VARCHAR2(500);
    E_MORE_THAN_FIVE EXCEPTION;
BEGIN
    V_SALARY:=2100;
    --2100 UNO SOLO
    --2500 MAS DE CINCO
    --9000 MAS DE UNO
    
    SELECT COUNT(EMPLOYEE_ID)
    INTO V_COUNT_ROW
    FROM EMPLOYEES
    WHERE SALARY=V_SALARY;
    
    IF V_COUNT_ROW>5 THEN
        RAISE E_MORE_THAN_FIVE;
    END IF;
    
    SELECT *
    INTO V_ROW_EMPLOYEE
    FROM EMPLOYEES
    WHERE SALARY=V_SALARY;
    
    DBMS_OUTPUT.PUT_LINE('EXISTE UN EMPLEADO CON EL SALARIO: '|| V_SALARY || ' Y SE LLAMA ' || V_ROW_EMPLOYEE.FIRST_NAME || ' '|| V_ROW_EMPLOYEE.LAST_NAME  );
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('NO EXISTE EMPLEADO CON EL SALARIO INGRESADO : ' || V_SALARY  );
    WHEN E_MORE_THAN_FIVE THEN
        DBMS_OUTPUT.PUT_LINE('EXISTEN MAS DE 5 PERSONAS CON EL SALARIO INGRESADO: ' || V_SALARY);
    WHEN TOO_MANY_ROWS THEN
       DBMS_OUTPUT.PUT_LINE('EXISTE MAS DE UN EMPLEADO CON EL SALARIO INGRESADO : ' || V_SALARY  );
    WHEN OTHERS THEN
        V_SQLCODE := SQLCODE;
        V_SQLERRM := SQLERRM;
        DBMS_OUTPUT.PUT_LINE('OCURRIO UN ERROR INESPERADO. CODIGO DE ERROR: ' || V_SQLCODE || ' - MENSAJE: ' || V_SQLERRM );
END;