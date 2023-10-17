

-- 1. Ver todos los registros
SELECT * FROM users;

-- 2. Ver el registro cuyo id sea igual a 10
SELECT * FROM users
WHERE id = 10;

-- 3. Quiero todos los registros que cuyo primer nombre sea Jim (engañosa)
SELECT * FROM users
WHERE name LIKE 'Jim %';

-- 4. Todos los registros cuyo segundo nombre es Alexander
SELECT * FROM users
WHERE name LIKE '% Alexander';

-- 5. Cambiar el nombre del registro con id = 1, por tu nombre Ej:'Fernando Herrera'
UPDATE users
SET name = 'Jhon Doe'
WHERE id = 1;

-- 6. Borrar el último registro de la tabla
DELETE FROM users
WHERE id = (SELECT COUNT(*) FROM users);
--OR
DELETE FROM users
WHERE id = (SELECT MAX(id) FROM users);

-- Agregar columnas y datos
SELECT name, 
	SUBSTRING(name, 0, POSITION(' ' IN name)) AS first_name, 
	SUBSTRING(name, POSITION(' ' IN name) + 1) AS last_name 
FROM users

ALTER TABLE users 
ADD COLUMN first_name VARCHAR(50), 
ADD COLUMN last_name VARCHAR(50);

UPDATE users 
SET first_name = SUBSTRING(name, 0, POSITION(' ' IN name)),
	last_name = SUBSTRING(name, POSITION(' ' IN name) + 1);
	
SELECT * FROM users;
	