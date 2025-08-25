# Brain Tasks App

This project is a React application. I deployed it on **AWS EKS** using Docker and CodeBuild. The app runs on **port 3000**.

---

## Steps I did

### 1. Clone repo
```bash
git clone https://github.com/Vennilavan12/Brain-Tasks-App.git
cd Brain-Tasks-App
```

### 2. Docker
- Created Dockerfile with nginx:alpine
- Copied dist/ files and nginx.conf
- Expose port 3000

```bash
docker build -t <my-ecr-repo>:latest .
docker push <my-ecr-repo>:latest
```

### 3. Kubernetes
- Created deployment.yml with 2 replicas
- Created service.yml as LoadBalancer on port 3000

```bash
kubectl apply -f k8s/deployment.yml
kubectl apply -f k8s/service.yml
```

### 4. CodeBuild
- Created project in AWS
- Connected GitHub repo
- Wrote buildspec.yml to build Docker, push to ECR, and deploy to EKS

### 5. CodeDeploy
- Created CodeDeploy application
- Added appspec.yml for deploying Docker images to EKS

### 6. CodeDeploy 
```bash
kubectl apply -f k8s/deployment.yml
kubectl apply -f k8s/service.yml
```
- Open EXTERNAL-IP with port 3000 in browser

### 7. Monitoring
- Used CloudWatch Logs to track CodeBuild build logs and application logs

### 8. Architecture Flow
```GitHub --> CodeBuild --> ECR --> EKS (Deployment & Service) --> Browser```

### Notes
- App runs only on port 3000
- LoadBalancer service type is used
- Make sure EKS cluster is running before deploying


