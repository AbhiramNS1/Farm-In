FROM mysql:latest

COPY ./database.sql /docker-entrypoint-initdb.d/
ENV MYSQL_ROOT_PASSWORD = "mysqlpass"
EXPOSE 3306
CMD ["mysqld"]