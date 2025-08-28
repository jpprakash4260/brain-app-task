#!/bin/bash
set -e
echo "Service details:"
kubectl get svc brain-tasks-app-service -o wide

HOST=$(kubectl get svc brain-tasks-app-service -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
echo "LoadBalancer Host: $HOST"
