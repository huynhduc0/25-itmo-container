from flask import Flask
import psycopg2
import os

app = Flask(__name__)

def get_db_connection():
    conn = psycopg2.connect(
        host=os.environ.get('DB_HOST'),
        port=os.environ.get('DB_PORT'),
        dbname=os.environ.get('DB_NAME'),
        user=os.environ.get('DB_USER'),
        password=os.environ.get('DB_PASSWORD')
    )
    return conn

@app.route('/')
def hello_world():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute('SELECT NOW()')
    db_time = cur.fetchone()
    cur.close()
    conn.close()
    return f'Hello, World from Flask App! Current DB Time: {db_time[0]}'

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
