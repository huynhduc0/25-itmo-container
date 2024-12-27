import os
import psycopg2
import time
from flask import Flask, jsonify

app = Flask(__name__)

# Get environment variables
DB_HOST = os.getenv("DB_HOST", "localhost")
DB_PORT = os.getenv("DB_PORT", "5432")
DB_NAME = os.getenv("DB_NAME", "mydatabase")
DB_USER = os.getenv("DB_USER", "myuser")
DB_PASSWORD = os.getenv("DB_PASSWORD", "mysecretpassword")

# Connect to PostgreSQL database with retries
def get_db_connection():
    retries = 5
    while retries > 0:
        try:
            conn = psycopg2.connect(
                host=DB_HOST,
                port=DB_PORT,
                dbname=DB_NAME,
                user=DB_USER,
                password=DB_PASSWORD
            )
            return conn
        except psycopg2.OperationalError:
            retries -= 1
            time.sleep(3)
    raise Exception("Unable to connect to the database after multiple attempts")

@app.route('/')
def hello_world():
    return 'Hello, World from Flask App!'
    
@app.route('/healthz')
def health_check():
    return "OK", 200
@app.route('/db-data')
def get_db_data():
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute('SELECT * FROM example;')
        records = cursor.fetchall()
        cursor.close()
        conn.close()

        if records:
            return jsonify(records), 200
        else:
            return jsonify({"message": "No data found"}), 404
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
