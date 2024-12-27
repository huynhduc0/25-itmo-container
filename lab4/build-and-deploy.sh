#!/bin/bash

# Load environment variables from .env file
if [ -f ".env" ]; then
    echo "Loading environment variables from .env file..."
    export $(grep -v '^#' .env | xargs)
else
    echo "Error: .env file not found. Please create one with the required variables."
    exit 1
fi

# Check if required environment variables are set
if [[ -z "${DOCKER_IMAGE}" || -z "${DOCKER_TAG}" || -z "${DOCKER_USERNAME}" || -z "${DOCKER_PASSWORD}" || -z "${HELM_RELEASE}" || -z "${HELM_CHART_DIR}" ]]; then
    echo "Error: One or more required environment variables are not set in the .env file."
    echo "Ensure the following variables are set: DOCKER_IMAGE, DOCKER_TAG, DOCKER_USERNAME, DOCKER_PASSWORD, HELM_RELEASE, HELM_CHART_DIR"
    exit 1
fi

# 1. Log in to Docker Hub
echo "Logging in to Docker Hub..."
echo "${DOCKER_PASSWORD}" | docker login --username "${DOCKER_USERNAME}" --password-stdin
if [ $? -ne 0 ]; then
    echo "Docker login failed. Please check your credentials."
    exit 1
fi

# 2. Build the Docker image
echo "Building Docker image..."
docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} .
if [ $? -ne 0 ]; then
    echo "Failed to build Docker image."
    exit 1
fi

# 3. Push the Docker image to Docker Hub
echo "Pushing Docker image to Docker Hub..."
docker push ${DOCKER_IMAGE}:${DOCKER_TAG}
if [ $? -ne 0 ]; then
    echo "Failed to push Docker image."
    exit 1
fi

# 4. Deploy the Helm chart
echo "Deploying Helm chart..."
helm upgrade --install ${HELM_RELEASE} ${HELM_CHART_DIR}
if [ $? -ne 0 ]; then
    echo "Failed to deploy Helm chart."
    exit 1
fi

# 5. Verify deployment
echo "Verifying deployment..."
kubectl get pods -l app=flask-app
kubectl get services -l app=flask-app

echo "Deployment completed successfully!"
