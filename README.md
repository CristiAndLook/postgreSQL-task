#Database with PostgreSQL

##Steps to lift the database and Pgadmin4

1. Clone the repository
2. Before running docker compose up you should create the folder and give it permissions if you are not a root user.
2. Running mkdir pgadmin-data && chmod -R 777 ./pgadmin-data 
3. Run docker-compose up -d
4. Open the browser and go to http://localhost:5050
5. Login with the credentials: 
    * user/email:
    * password:
6. Create a new server with the following credentials:
    * host: postgres-db
    * port: 5432
    * username: admin
    * password: admin
7. Create a new database with the name: postgres


