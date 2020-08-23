FROM library/postgres:9.6

COPY docker-compose-local-db.sh /docker-entrypoint-initdb.d/

RUN chmod +x .docker-entrypoint-initdb.d/docker-compose-local-db.sh

EXPOSE 5432