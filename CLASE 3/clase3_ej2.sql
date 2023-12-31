SET SERVEROUTPUT ON
DECLARE

    CURSOR CUR_EMP (P_JOB_ID EMPLOYEES.JOB_ID%TYPE) IS
        SELECT EMPLOYEE_ID, SALARY
        FROM EMPLOYEES
        WHERE JOB_ID = P_JOB_ID;
    
    V_JOB_ID EMPLOYEES.JOB_ID%TYPE;
    V_SALARY_SUM EMPLOYEES.SALARY%TYPE;
    V_ROW_COUNT NUMBER;
    V_SALARY_AVG EMPLOYEES.SALARY%TYPE;
    V_SQLCODE NUMBER;
    V_SQLERRM VARCHAR2(500);
    E_HIGH_SALARY_SUM EXCEPTION;
    
BEGIN
    V_JOB_ID := 'AD_VP';
    --FI_ACCOUNT: MAS DE UN EMPLEADO
    --AC_ACCOUNT: SOLO UN EMPLEADO
    --ACCOUNT: NO EXISTE
    --AD_PRES: EXCEPTION DENTRO DEL LOOP Y SUMATORIA DE SALARIOS MAYOR A UN VALOR
    --AD_VP: DOS EXCEPTION DENTRO DEL LOOP Y SUMATORIA DE SALARIOS MAYOR A UN VALOR
    V_SALARY_SUM := 0;
    V_ROW_COUNT := 0;
    V_SALARY_AVG := 0;
    FOR V_ROW IN CUR_EMP(V_JOB_ID) LOOP
        BEGIN
            V_SALARY_SUM := V_SALARY_SUM + V_ROW.SALARY;
            V_ROW_COUNT := V_ROW_COUNT + 1;
            IF V_ROW.SALARY > 15000 THEN
                RAISE_APPLICATION_ERROR(-20596, 'JOB ID: ' || V_JOB_ID ||' TIENE UN SALARIO QUE SUPERA LOS 15000.');
            END IF;
        EXCEPTION
            WHEN OTHERS THEN
            V_SQLCODE := SQLCODE;
            V_SQLERRM := SQLERRM;
            DBMS_OUTPUT.PUT_LINE('OCURRIO UN ERROR INESPERADO. CODIGO ERROR: ' || V_SQLCODE || ' - MENSAJE: ' || V_SQLERRM );
        END;
   
    END LOOP;
     IF V_ROW_COUNT = 0 THEN
        RAISE NO_DATA_FOUND;
    END IF;
    
    V_SALARY_AVG := V_SALARY_SUM/V_ROW_COUNT;
        
    IF V_SALARY_SUM > 20000 THEN
        RAISE E_HIGH_SALARY_SUM;
    END IF;
    
    IF V_ROW_COUNT > 1 THEN
        RAISE TOO_MANY_ROWS;
    END IF;

    DBMS_OUTPUT.PUT_LINE('EL PROMEDIO DE LOS SALARIOS DE LOS EMPLEADOS(EXISTE SOLO UNO BAJO ESTE JOB ID) ES: ' || V_SALARY_AVG);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('NO EXISTE NINGUN EMPLEADO CON EL JOB INGRESADO.');
    WHEN E_HIGH_SALARY_SUM THEN
        DBMS_OUTPUT.PUT_LINE('EL MONTO TOTAL DE SALARIOS SUPERA EL LIMITE.');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('EXISTE MAS DE UN EMPLEADO CON EL JOB INGRESADO.');
        DBMS_OUTPUT.PUT_LINE('EL PROMEDIO DE LOS SALARIOS DE LOS EMPLEADOS ES: ' || V_SALARY_AVG);
        
    WHEN OTHERS THEN
        V_SQLCODE := SQLCODE;
        V_SQLERRM := SQLERRM;
        DBMS_OUTPUT.PUT_LINE('OCURRIO UN ERROR INESPERADO. CODIGO ERROR: ' || V_SQLCODE || ' - MENSAJE: ' || V_SQLERRM );

END ;