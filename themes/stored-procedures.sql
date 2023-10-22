-- Database ./records-tables/employees.sql
-- Basic example of a stored procedure
CREATE OR REPLACE PROCEDURE insert_region_proc( INT, VARCHAR )
AS $$
BEGIN
    INSERT INTO regions (region_id, region_name)
    VALUES ($1, $2);

    COMMIT;
END;
$$ LANGUAGE plpgsql;

-- Call the stored procedure
CALL insert_region_proc(5, 'Southwest');

-- Example with ./records-tables/raise_history.sql 

CREATE OR REPLACE PROCEDURE cotrolled_raise ( percentage NUMERIC )
AS $$
DECLARE
    real_percentage NUMERIC(8,2);
    total_employees INTEGER;
BEGIN
    real_percentage := percentage / 100;

    -- Mantener el historico de los salarios
    INSERT INTO raise_history (date, employee_id, base_salary, amount, percentage)
    SELECT CURRENT_DATE AS date, employee_id, salary, max_raise(employee_id) * real_percentage AS amount, percentage
    FROM employees

    -- Impactar el aumento en la tabla de empleados
    UPDATE employees
    SET salary = salary + (max_raise(employee_id) * real_percentage)
    
    SELECT count(*) INTO total_employees FROM employees;
    RAISE NOTICE 'Se ha aumentado el salario de % empleados', total_employees;
END;
$$ LANGUAGE plpgsql;

CALL cotrolled_raise(5); 