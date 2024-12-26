# Use a specific, lightweight base image
FROM jupyterhub/jupyterhub:3.1.1

# Set a meaningful working directory
WORKDIR /srv/jupyterhub

# Install only necessary dependencies and clean up cache
RUN apt-get update && \
    apt-get install -y python3-dev git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Use CMD for flexibility with default behavior
CMD ["jupyterhub", "--log-level=DEBUG"]
