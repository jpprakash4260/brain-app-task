#!/bin/bash
set -e
cd /opt/brain-tasks-app

# read image uri written by CodeBuild
IMAGE_URI=$(jq -r '.ImageURI' imagedefinitions.json)
echo "Deploying image: $IMAGE_URI"

# Ensure manifests exist
test -f k8s/deployment.yml
test -f k8s/service.yml

# First apply manifests (create if missing)
kubectl apply -f k8s/deployment.yml
kubectl apply -f k8s/service.yml

# Update image on the existing deployment
kubectl set image deployment/brain-tasks-app brain-tasks-app="$IMAGE_URI" --record

# Wait for rollout
kubectl rollout status deployment/brain-tasks-app --timeout=180s
