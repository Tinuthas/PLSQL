set serveroutput on 

CREATE TABLE TOP_EMPS AS SELECT * FROM EMPLOYEES WHERE 1 = 0 ;

ACCEPT P_QTD PROMPT 'INFORME O NUMERO DE FUNCIONARIOS'

declare 
    V_QTD INT := &P_QTD;
    V_LN EMPLOYEES.LAST_NAME%TYPE;
    V_SAL EMPLOYEES.SALARY%TYPE;
    cursor cur_emp is
        select last_name, salary
        from employees
        ORDER BY 2 DESC;
begin 
    OPEN cur_emp;
    FETCH cur_emp INTO V_LN, V_SAL;
    WHILE cur_emp%FOUND AND cur_emp%ROWCOUNT <= V_QTD loop
        DBMS_OUTPUT.PUT_LINE(V_LN ||' '||V_SAL);
        INSERT INTO TOP_EMPS
        VALUES (V_LN, V_SAL);
        FETCH cur_emp INTO V_LN, V_SAL;
    END LOOP;
    COMMIT;
    CLOSE cur_emp;
end;
/