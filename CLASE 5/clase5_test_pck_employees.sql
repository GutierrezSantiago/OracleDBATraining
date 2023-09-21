SET SERVEROUTPUT ON;
DECLARE
    V_ID NUMBER;
    V_ERROR VARCHAR2(400);
    O_CUR SYS_REFCURSOR;
BEGIN
    PCK_EMPLOYEES.pr_consulta_employees(204, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, O_CUR, V_ID, V_ERROR);
    DBMS_SQL.return_result(O_CUR);
    
    PCK_EMPLOYEES.pr_MODIFICACION_employees(204, 'Julian', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, V_ID, V_ERROR);
    PCK_EMPLOYEES.pr_consulta_employees(204, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, O_CUR, V_ID, V_ERROR);
    DBMS_SQL.return_result(O_CUR);
    
    PCK_EMPLOYEES.pr_MODIFICACION_employees(204, 'Hermann', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, V_ID, V_ERROR);
    PCK_EMPLOYEES.pr_consulta_employees(204, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, O_CUR, V_ID, V_ERROR);
    DBMS_SQL.return_result(O_CUR);
    
    PCK_EMPLOYEES.pr_consulta_employees(NULL, NULL, 'Gutierrez', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, O_CUR, V_ID, V_ERROR);
    DBMS_SQL.return_result(O_CUR);
    
    PCK_EMPLOYEES.pr_alta_employees(800, 'Santiago', 'Gutierrez', 'SGUT', '351.555.5555', TO_DATE('2022/10/20', 'yyyy/mm/dd'), 'PR_REP', 10000, NULL, NULL, NULL, V_ID, V_ERROR);
    PCK_EMPLOYEES.pr_consulta_employees(NULL, NULL, 'Gutierrez', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, O_CUR, V_ID, V_ERROR);
    DBMS_SQL.return_result(O_CUR);
    
    PCK_EMPLOYEES.pr_baja_employees(800, V_ID, V_ERROR);
    PCK_EMPLOYEES.pr_consulta_employees(NULL, NULL, 'Gutierrez', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, O_CUR, V_ID, V_ERROR);
    DBMS_SQL.return_result(O_CUR);
    
END;