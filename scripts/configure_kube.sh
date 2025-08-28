#!/bin/bash
set -e
REGION="${AWS_DEFAULT_REGION:-ap-south-1}"
CLUSTER_NAME="${CLUSTER_NAME:-brain-tasks-app}"

echo "Updating kubeconfig for $CLUSTER_NAME in $REGION ..."
aws eks update-kubeconfig --name "$CLUSTER_NAME" --region "$REGION"

echo "Cluster nodes:"
kubectl get nodes -o wide
