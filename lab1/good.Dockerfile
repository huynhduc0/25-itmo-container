# Use a specific, lightweight base image
FROM python:3.9-slim

# Set a meaningful working directory
WORKDIR /app

# Copy only necessary files
COPY app.py /app/

# Install only necessary dependencies and clean up cache
RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc && \
    pip install flask && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Use CMD for flexibility with default behavior
CMD ["python", "app.py"]
