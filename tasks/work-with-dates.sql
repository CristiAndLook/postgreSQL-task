SELECT * FROM employees
ORDER BY hire_date DESC

SELECT hire_date + MAKE_INTERVAL( 
	YEARS := date_part('years', CURRENT_DATE)::INTEGER - EXTRACT( YEARS FROM hire_date)::INTEGER
) FROM employees


UPDATE employees
SET hire_date = hire_date + INTERVAL '23 years'

SELECT hire_date + INTERVAL '23 years'FROM employees