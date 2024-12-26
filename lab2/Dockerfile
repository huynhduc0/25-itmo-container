# Dockerfile
FROM python:3.8-slim

RUN pip install flask psycopg2-binary

COPY app.py /app.py

EXPOSE 5000

CMD ["python", "app.py"]
