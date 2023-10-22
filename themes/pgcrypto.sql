CREATE EXTENSION pgcrypto;

-- Create a table 'users' with a column 'password' of type 'text'

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password TEXT NOT NULL,
    last_login TIMESTAMP
);

-- Create table session_failed

CREATE TABLE session_failed (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    try_login TIMESTAMP
);

-- Insert a user with a password

INSERT INTO users (username, password) VALUES ('admin', crypt('admin', gen_salt('bf')));

-- Check if the password is correct

SELECT * FROM users WHERE username = 'admin' AND password = crypt('admin', password);

-- Check if the password is incorrect

SELECT * FROM users WHERE username = 'admin' AND password = crypt('wrong', password);

-- Check the password with crypt()

SELECT * FROM users WHERE username = 'admin' AND password = crypt('admin', password);

-- User login with stored procedure

CREATE OR REPLACE FUNCTION login(username VARCHAR, password VARCHAR) 
RETURNS BOOLEAN 
AS $$
DECLARE 
    result BOOLEAN;
BEGIN
    SELECT count(*) INTO result FROM "users"
    WHERE "username" = username AND "password" = crypt(password, "password"); 

    IF (result = false ) THEN
        INSERT INTO session_failed (username, try_login) VALUES (username, now());
        COMMIT;
        RAISE EXCEPTION 'Invalid username or password';
    END IF;

    RAISE NOTICE 'Login result: %', result;

    UPDATE "users" SET "last_login" = now() WHERE "username" = username;
    RAISE NOTICE 'User % logged in', username;
END;

$$ LANGUAGE plpgsql;

CALL login('admin', 'admin');

-- Use a trigger to update the last_login column
CREATE OR REPLACE TRIGGER create_session_trigger AFTER UPDATE ON users
FOR EACH ROW 
WHEN(OLD.last_login IS DISTINCT FROM NEW.last_login)
EXECUTE PROCEDURE create_session_log();

CREATE OR REPLACE FUNCTION create_session_log() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO session_log (username, last_login) VALUES (NEW.username, NEW.last_login);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;





