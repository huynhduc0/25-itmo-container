# Bad Dockerfile
FROM jupyterhub/jupyterhub:3.1.1

# Install additional dependencies
RUN apt update && apt -y install python3-dev git

# Install unnecessary packages
RUN apt -y install vim nano

# Arbitrary working directory
WORKDIR jupyter

# Improper entrypoint
ENTRYPOINT jupyterhub --log-level=DEBUG
