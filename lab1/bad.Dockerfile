# Bad Dockerfile
FROM python:3.9-slim

# Install additional dependencies
RUN apt-get update && apt-get install -y python3-dev gcc

# Install unnecessary packages
RUN apt-get install -y vim nano

# Arbitrary working directory
WORKDIR /app

# Copy all files
COPY . /app

# Improper entrypoint
ENTRYPOINT ["python", "app.py"]
