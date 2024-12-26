#!/bin/bash

# Wait for the PostgreSQL database to be ready
until pg_isready -h db -U myuser; do
  echo "Waiting for PostgreSQL to be ready..."
  sleep 2
done

# Create the table if it doesn't exist
PGPASSWORD=mysecretpassword psql -h db -U myuser -d mydatabase -c "CREATE TABLE IF NOT EXISTS example (id SERIAL PRIMARY KEY, data TEXT);"

# Insert initial data into the table
PGPASSWORD=mysecretpassword psql -h db -U myuser -d mydatabase -c "INSERT INTO example (data) VALUES ('Sample Data 1'), ('Sample Data 2'), ('Sample Data 3');"

echo "Database initialized and data inserted."
