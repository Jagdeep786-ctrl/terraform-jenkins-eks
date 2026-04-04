# 🌾 Crop Price Dashboard  
## Production-Grade CI/CD Deployment on AWS EKS

![AWS](https://img.shields.io/badge/AWS-EKS-orange?logo=amazon-aws)
![Terraform](https://img.shields.io/badge/Terraform-IaC-623CE4?logo=terraform)
![Kubernetes](https://img.shields.io/badge/Kubernetes-Orchestration-326CE5?logo=kubernetes)
![Docker](https://img.shields.io/badge/Docker-Containers-2496ED?logo=docker)
![Jenkins](https://img.shields.io/badge/Jenkins-CI/CD-D24939?logo=jenkins)
![License](https://img.shields.io/badge/License-MIT-green)

---

## 📌 Overview

This project showcases a **production-grade DevOps pipeline** for deploying a Crop Price Dashboard using modern cloud-native practices. It demonstrates how to design, automate, and manage a scalable application lifecycle — from infrastructure provisioning to application delivery.

The system leverages:

- Infrastructure as Code (IaC)
- Kubernetes-based microservices architecture
- Automated CI/CD pipelines
- Scalable and highly available AWS infrastructure

---

## 🎯 Key Objectives

- Automate infrastructure provisioning on AWS  
- Implement robust CI/CD pipelines using Jenkins  
- Deploy containerized microservices on Kubernetes (EKS)  
- Ensure scalability, reliability, and high availability  
- Enable automated validation and deployment verification  

---

## 🏗️ Architecture Overview

```
Developer → GitHub (SCM)
        ↓
Jenkins CI/CD Pipelines
        ↓
Terraform (IaC Provisioning)
        ↓
AWS EKS Cluster (Kubernetes)
        ↓
Application Deployment (Pods & Services)
        ↓
AWS ALB Ingress Controller
        ↓
End Users (Browser Access)
```

---

## ⚙️ Technology Stack

### ☁️ Cloud & Infrastructure
- AWS (EKS, EC2, IAM, ALB, VPC)
- Terraform (Infrastructure as Code)

### 🚀 CI/CD
- Jenkins (Pipeline automation)
- GitHub (Version control)

### 🐳 Containerization & Orchestration
- Docker
- Kubernetes (EKS)

### 🌐 Application Layer
- React.js (Frontend)
- Node.js (API Gateway / Backend)
- Python (ML / Trend Service)
- MySQL (Database)

---

## 🔄 CI/CD Pipeline Design

The system follows a **modular multi-pipeline architecture** to improve maintainability and scalability.

---

### 🔹 1. Infrastructure CI Pipeline  
📄 `Jenkinsfile.infra-ci`

**Purpose:** Validate Terraform configurations before deployment  

**Key Stages:**
- `terraform init`
- `terraform plan`
- Configuration validation

✔️ Prevents faulty infrastructure changes  

---

### 🔹 2. Infrastructure CD Pipeline  
📄 `Jenkinsfile.infra-cd`

**Purpose:** Provision and update AWS infrastructure  

**Key Actions:**
- Execute `terraform apply`
- Provision:
  - EKS Cluster  
  - Node Groups  
  - IAM Roles & Policies  
  - Networking (VPC, Subnets)

✔️ Fully automated infrastructure deployment  

---

### 🔹 3. Application Deployment Pipeline  
📄 `Jenkinsfile.app-deploy`

**Purpose:** Deploy application services to Kubernetes  

**Key Stages:**
- Build Docker images  
- Push images to registry  
- Deploy Kubernetes manifests  
- Configure ALB Ingress Controller  

✔️ Enables continuous delivery of application updates  

---

### 🔹 4. Deployment Verification Pipeline  
📄 `Jenkinsfile.verify-deployment`

**Purpose:** Validate deployment health and system status  

**Validation Commands:**
```
kubectl get pods
kubectl get nodes
kubectl get svc
kubectl get ingress
```

✔️ Ensures system reliability post-deployment  

---

## 🔐 Security & Access Control

- IAM roles configured for:
  - EKS Cluster
  - Worker Nodes
  - Jenkins pipeline access
- OIDC provider enabled for Kubernetes service accounts  
- Followed **least privilege principle** for secure access  

---

## 🌐 Application Exposure

The application is exposed using:

- AWS Application Load Balancer (ALB)  
- Kubernetes Ingress Controller  

**Access Endpoint:**
```
http://<ALB-DNS> 

```

✔️ Provides secure and scalable external access  

---

## 📊 End-to-End Workflow

1. Developer pushes code to GitHub  
2. Jenkins pipeline triggers automatically  
3. Terraform provisions/updates AWS infrastructure  
4. Docker images are built and pushed  
5. Kubernetes deployments are updated  
6. ALB exposes application to users  
7. Verification pipeline validates deployment  

---

## 🧠 Key Highlights

- 🚀 Fully automated CI/CD pipeline  
- 🏗️ Infrastructure as Code using Terraform  
- ☸️ Kubernetes deployment on AWS EKS  
- 🔄 Modular multi-pipeline architecture  
- 🔐 Secure IAM integration  
- 🌐 Production-grade ALB exposure  
- ✅ Automated deployment verification  

---

## 💬 Interview Explanation

“I designed and implemented a production-grade DevOps pipeline using Jenkins and Terraform. I separated infrastructure and application pipelines to improve modularity and scalability. Terraform provisions AWS resources including EKS, while Jenkins automates CI/CD workflows. The application runs on Kubernetes and is exposed via an ALB, with an additional verification pipeline to ensure deployment reliability.”

---

## 🚀 Future Enhancements

- Implement Helm charts for deployment standardization  
- Add Horizontal Pod Autoscaler (HPA)  
- Integrate Prometheus & Grafana monitoring  
- Adopt GitOps using ArgoCD  
- Enable HTTPS using AWS ACM and Route53  

---

## 👨‍💻 Author

Jagdeep Sodhi
