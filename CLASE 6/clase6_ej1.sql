CREATE OR REPLACE TRIGGER TG_EMPS_INSERT
BEFORE INSERT ON employees
FOR EACH ROW
DECLARE
V_MIN_SALARY JOBS.MIN_SALARY%TYPE;
V_MAX_SALARY JOBS.MAX_SALARY%TYPE;
V_SQLCODE NUMBER;
V_SQLERRM VARCHAR2(500);
BEGIN
    IF (:NEW.JOB_ID = 'ST_CLERK' OR :NEW.JOB_ID = 'SA_REP' OR :NEW.JOB_ID = 'IT_PROG') THEN
        SELECT MIN_SALARY, MAX_SALARY INTO V_MIN_SALARY, V_MAX_SALARY FROM JOBS WHERE JOB_ID = :NEW.JOB_ID;
        IF :NEW.SALARY > V_MAX_SALARY THEN
            INSERT INTO EMP_LOG(EMPLOYEE_ID, SALARY, JOB_ID, MSG) VALUES (:NEW.employee_id, :NEW.salary, :NEW.job_id, 'EL SALARIO INGRESADO SUPERA EL MONTO MAXIMO.');
        END IF;
        IF :NEW.SALARY < V_MIN_SALARY THEN
            INSERT INTO emp_log(EMPLOYEE_ID, salary, job_id, msg) VALUES (:NEW.employee_id, :NEW.salary, :NEW.job_id, 'EL SALARIO INGRESADO ES MENOR EL MONTO MINIMO.');
        END IF;
END IF;
EXCEPTION
    WHEN OTHERS THEN
        V_SQLCODE := SQLCODE;
        V_SQLERRM := SQLERRM;
        
        
        
END;