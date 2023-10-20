CREATE OR REPLACE FUNCTION hello()
RETURNS VARCHAR
AS
$$
BEGIN
    RETURN 'Hello World';
END;
$$
LANGUAGE plpgsql;

SELECT hello();

CREATE OR REPLACE FUNCTION hello( user_name VARCHAR )
RETURNS VARCHAR
AS
$$
BEGIN
    RETURN 'Hello ' || user_name;
END;
$$
LANGUAGE plpgsql;

SELECT hello(name) FROM users;