-- Database ./records-tables/employees.sql

CREATE OR REPLACE FUNCTION greet_employee( employee_name VARCHAR )
RETURN VARCHAR 
AS $$
-- DECLARE
BEGIN
    RETURN 'Hello ' || employee_name || '!';
END;
$$ LANGUAGE plpgsql;

SELECT greet_employee('John');
SELECT first_name, greet_employee(first_name) FROM employees




-- More examples
CREATE OR REPLACE FUNCTION max_raise( empl_id INT)
RETURNS NUMERIC(8,2)
AS $$
DECLARE
    posible_raise NUMERIC(8,2);
BEGIN
    
    SELECT max_salary - salary INTO posible_raise
    FROM employees
    INNER JOIN jobs ON employees.job_id = jobs.job_id
    WHERE employee_id = empl_id;

    IF posible_raise > 0 THEN
        RETURN posible_raise;
    ELSE
        RETURN 0;
    END IF;

END;
$$ LANGUAGE plpgsql;

SELECT employee_id, first_name ,max_raise(employee_id) FROM employees;

-- Other example
CREATE OR REPLACE FUNCTION max_raise_2( empl_id INT)
RETURNS NUMERIC(8,2)
AS $$
DECLARE
    employee_job_id INT;
    current_salary NUMERIC(8,2);
    job_max_salary NUMERIC(8,2);
    posible_raise NUMERIC(8,2);
BEGIN
        
        SELECT job_id, salary INTO employee_job_id, current_salary
        FROM employees
        WHERE employee_id = empl_id;
    
        SELECT max_salary INTO job_max_salary
        FROM jobs
        WHERE job_id = employee_job_id;
    
        posible_raise := job_max_salary - current_salary;
    
        IF posible_raise > 0 THEN
            RETURN posible_raise;
        ELSE
            RETURN 0;
        END IF;
    
END;
$$ LANGUAGE plpgsql;

-- Row type
CREATE OR REPLACE FUNCTION max_raise_2( empl_id int )
returns NUMERIC(8,2) as $$

DECLARE
	
	selected_employee employees%rowtype;
	selected_job jobs%rowtype;
	
	
	possible_raise NUMERIC(8,2);

BEGIN
	
	-- Tomar el puesto de trabajo y el salario
	select * from employees into selected_employee
	where employee_id = empl_id;

	-- Tomar el max salary, acorde a su job
	select * from jobs into selected_job
	where job_id = selected_employee.job_id;
	
	
	-- Cálculos
	possible_raise = selected_job.max_salary - selected_employee.salary;

	IF ( possible_raise < 0 ) THEN
		RAISE EXCEPTION 'Persona con salario mayor max_salary: id:%, %', selected_employee.employee_id, selected_employee.first_name;
-- 		possible_raise = 0;
	END IF;


	return possible_raise;
	
END;
$$ LANGUAGE plpgsql;
