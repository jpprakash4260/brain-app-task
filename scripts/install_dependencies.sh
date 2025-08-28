#!/bin/bash
set -e

# Basic tools
command -v jq >/dev/null 2>&1 || yum install -y jq || dnf install -y jq || apt-get update && apt-get install -y jq

# AWS CLI v2 (if not present)
if ! command -v aws >/dev/null 2>&1; then
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
  unzip -q /tmp/awscliv2.zip -d /tmp
  sudo /tmp/aws/install
fi

# kubectl (match cluster version automatically)
CLUSTER_NAME="${CLUSTER_NAME:-brain-tasks-app}"
REGION="${AWS_DEFAULT_REGION:-ap-south-1}"
EKS_VER=$(aws eks describe-cluster --name "$CLUSTER_NAME" --region "$REGION" --query "cluster.version" --output text)
if ! command -v kubectl >/dev/null 2>&1; then
  curl -L -o /usr/local/bin/kubectl "https://amazon-eks.s3.$REGION.amazonaws.com/$EKS_VER/2023-07-05/bin/linux/amd64/kubectl"
  chmod +x /usr/local/bin/kubectl
fi
