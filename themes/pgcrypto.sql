CREATE EXTENSION pgcrypto;

-- Create a table 'users' with a column 'password' of type 'text'

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password TEXT NOT NULL
);

-- Insert a user with a password

INSERT INTO users (username, password) VALUES ('admin', crypt('admin', gen_salt('bf')));

-- Check if the password is correct

SELECT * FROM users WHERE username = 'admin' AND password = crypt('admin', password);

-- Check if the password is incorrect

SELECT * FROM users WHERE username = 'admin' AND password = crypt('wrong', password);

-- Check the password with crypt()

SELECT * FROM users WHERE username = 'admin' AND password = crypt('admin', password);


