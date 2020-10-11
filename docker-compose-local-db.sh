#!/bin/bash

set -e

function create_user() {
	local owner=$(echo $1 | tr ',' ' ' | awk  '{print $1}')
	local pass=$(echo $1 | tr ',' ' ' | awk  '{print $2}')
  echo
	echo "Creating user '$owner' with password $pass"
	psql -v ON_ERROR_STOP=1 --username $POSTGRES_USER --dbname "$POSTGRES_DB" <<-EOSQL
		CREATE USER $owner WITH SUPERUSER PASSWORD '$pass';
EOSQL
}

function create_database() {
	local database=$(echo $1 | tr ',' ' ' | awk  '{print $1}')
	local owner=$(echo $1 | tr ',' ' ' | awk  '{print $2}')
  echo
	echo "Creating database $database and set privileges to $owner "
	psql -v ON_ERROR_STOP=1 --username $POSTGRES_USER --dbname "$POSTGRES_DB" <<-EOSQL
	    CREATE DATABASE $database;
	    GRANT ALL PRIVILEGES ON DATABASE $database TO $owner;
EOSQL
}

if [ -n "$POSTGRES_MULTIPLE_USERS" ]; then
  echo
	echo "    Multiple users creation requested: $POSTGRES_MULTIPLE_USERS"
	for usr in $(echo $POSTGRES_MULTIPLE_USERS | tr ':' ' '); do
		create_user $usr
	done
  echo
	echo "    Multiple users created"
fi

if [ -n "$POSTGRES_MULTIPLE_DATABASES" ]; then
  echo
	echo "    Multiple database creation requested: $POSTGRES_MULTIPLE_DATABASES"
	for db in $(echo $POSTGRES_MULTIPLE_DATABASES | tr ':' ' '); do
		create_database $db
	done
  echo
	echo "    Multiple database created"
fi
