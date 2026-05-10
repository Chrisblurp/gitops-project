# Production-Style GitOps DevOps Pipeline on Azure Kubernetes Service (AKS)

A complete production-style DevOps and GitOps platform demonstrating modern cloud-native deployment practices including CI/CD automation, Kubernetes orchestration, GitOps workflows, Infrastructure as Code, monitoring, ingress management, and Blue/Green deployment strategies.

This project simulates how modern DevOps teams build, secure, deploy, monitor, and manage scalable applications in production environments.

---

# Project Highlights

- Docker containerization
- GitHub Actions CI/CD pipeline
- DevSecOps image scanning with Trivy
- Kubernetes deployments
- GitOps workflow using ArgoCD
- Infrastructure as Code with Terraform
- Azure Kubernetes Service (AKS)
- Monitoring with Prometheus & Grafana
- NGINX Ingress Controller
- Blue/Green deployment strategy
- Cloud-native production workflow

---

# Architecture Overview

## End-to-End DevOps Workflow

```text
Developer Pushes Code
        ↓
GitHub Actions CI/CD Pipeline
        ↓
Docker Image Build
        ↓
Trivy Security Scan
        ↓
Push Docker Image to Registry
        ↓
ArgoCD GitOps Synchronization
        ↓
Deploy to Azure Kubernetes Service (AKS)
        ↓
Ingress Traffic Routing
        ↓
Prometheus Metrics Collection
        ↓
Grafana Dashboards & Observability
        ↓
Blue/Green Deployment Switching
```

---

# Tech Stack

## Cloud & Infrastructure

- Microsoft Azure
- Azure Kubernetes Service (AKS)
- Terraform
- Kubernetes
- Helm

## CI/CD & GitOps

- GitHub Actions
- ArgoCD
- GitOps Workflow

## Containerization

- Docker
- DockerHub

## Monitoring & Observability

- Prometheus
- Grafana

## Security

- Trivy vulnerability scanner

## Networking

- NGINX Ingress Controller
- Kubernetes Services

## Development

- Python
- YAML
- Bash

---

# Project Structure

```bash
.
├── app/
├── k8s/
│   ├── deployment.yaml
│   ├── deployment-green.yaml
│   ├── service.yaml
│   └── ingress.yaml
├── terraform/
├── .github/
│   └── workflows/
├── monitoring/
├── screenshots/
├── scripts/
└── README.md
```

---

# Features

- Fully containerized application
- Automated CI/CD pipeline
- GitOps deployment workflow
- Kubernetes orchestration
- Infrastructure as Code provisioning
- Security vulnerability scanning
- Monitoring & observability
- Internal ingress routing
- Blue/Green deployment strategy
- Cloud-native architecture

---

# Local Development Setup

## Prerequisites

Install the following tools:

- Git
- Docker
- kubectl
- Helm
- Terraform
- Azure CLI
- Minikube or Docker Desktop

---

# Clone Repository

```bash
git clone https://github.com/Chrisblurp/gitops-project.git

cd project-root
```

---

# Run Application Locally

```bash
cd app

python app.py
```

Open in browser:

```text
http://localhost:5000
```

---

# Dockerization

## Build Docker Image

```bash
docker build -t your-dockerhub-username/gitops-devops-app .
```

---

# Run Container

```bash
docker run -p 5000:5000 your-dockerhub-username/gitops-devops-app
```

---

# Push Image to DockerHub

```bash
docker login

docker push your-dockerhub-username/gitops-devops-app
```

---

# CI/CD Pipeline

The project includes a fully automated GitHub Actions CI/CD pipeline.

---

# Pipeline Workflow

The pipeline automatically:

- Checks out source code
- Builds Docker images
- Scans container images using Trivy
- Pushes images to DockerHub
- Triggers Kubernetes deployment
- Synchronizes deployment through ArgoCD

---

# GitHub Actions Trigger

Pipeline runs on:

- Push to main branch
- Pull requests

---

# DevSecOps Security Scanning

Security scanning is integrated into the CI/CD workflow using Trivy.

This helps identify:

- Vulnerable packages
- Misconfigurations
- Container security issues

---

# Kubernetes Deployment

## Apply Kubernetes Deployment

```bash
kubectl apply -f k8s/deployment.yaml
```

---

# Expose Application Service

```bash
kubectl apply -f k8s/service.yaml
```

---

# Verify Kubernetes Resources

```bash
kubectl get pods
kubectl get svc
kubectl get deployments
```

---

# Azure Kubernetes Service (AKS)

Infrastructure was provisioned and deployed on Microsoft Azure using Azure Kubernetes Service (AKS).

---

# Connect to AKS Cluster

```bash
az aks get-credentials \
  --resource-group <RESOURCE_GROUP> \
  --name <AKS_CLUSTER_NAME>
```

---

# Verify Cluster Connection

```bash
kubectl get nodes
```

---

# Infrastructure as Code

Terraform was used to provision and manage cloud infrastructure resources.

---

# Terraform Workflow

## Initialize Terraform

```bash
cd terraform

terraform init
```

---

# Plan Infrastructure

```bash
terraform plan
```

---

# Apply Infrastructure

```bash
terraform apply
```

---

# GitOps Deployment with ArgoCD

ArgoCD is used to implement GitOps continuous deployment workflows.

---

# Install ArgoCD

```bash
kubectl create namespace argocd

kubectl apply -n argocd \
-f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

---

# Access ArgoCD

```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

---

# GitOps Deployment Workflow

1. Connect GitHub repository in ArgoCD
2. Create application definition
3. Sync Kubernetes manifests
4. Automatically deploy updates to AKS cluster

---

# Monitoring & Observability

The project implements monitoring and observability using Prometheus and Grafana.

---

# Install Prometheus

```bash
helm install prometheus prometheus-community/prometheus
```

---

# Install Grafana

```bash
helm install grafana prometheus-community/grafana
```

---

# Access Grafana

```bash
kubectl port-forward svc/grafana 3000:80
```

---

# Monitoring Features

- Kubernetes metrics monitoring
- Application health visualization
- Cluster observability dashboards
- Real-time monitoring insights

---

# Internal Ingress Configuration

NGINX Ingress Controller is used for internal traffic routing.

---

# Install Ingress Controller

```bash
helm install ingress-nginx ingress-nginx/ingress-nginx \
--set controller.service.type=ClusterIP
```

---

# Apply Ingress Configuration

```bash
kubectl apply -f k8s/ingress.yaml
```

---

# Access Application Through Ingress

```bash
kubectl port-forward svc/ingress-nginx-controller 8081:80
```

Open in browser:

```text
http://localhost:8081
```

---

# Blue/Green Deployment Strategy

The project implements Blue/Green deployment for zero-downtime application releases.

---

# Deploy Green Version

```bash
kubectl apply -f k8s/deployment-green.yaml
```

---

# Switch Traffic to Green Environment

```bash
kubectl edit svc gitops-service
```

Update selector:

```yaml
version: green
```

---

# Rollback Deployment (Optional)

Switch selector back to:

```yaml
version: blue
```

---

# Skills Demonstrated

- Azure Cloud Infrastructure
- Azure Kubernetes Service (AKS)
- Kubernetes administration
- GitOps workflows
- CI/CD pipeline automation
- Docker containerization
- DevSecOps implementation
- Terraform Infrastructure as Code
- Monitoring & observability
- NGINX ingress configuration
- Blue/Green deployments
- Cloud-native DevOps workflows

---


# Lessons Learned

Through this project, I gained practical experience with:

- Implementing production-style DevOps pipelines
- Building GitOps deployment workflows
- Managing Kubernetes infrastructure
- Deploying applications into AKS
- Automating CI/CD processes
- Implementing monitoring solutions
- Managing ingress traffic routing
- Performing security vulnerability scanning
- Deploying Blue/Green release strategies

---

