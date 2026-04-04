# 🌾 Crop Dashboard – CI/CD Deployment on AWS EKS with Jenkins & Terraform

![AWS](https://img.shields.io/badge/AWS-EKS-orange?logo=amazon-aws)
![Terraform](https://img.shields.io/badge/Terraform-IaC-623CE4?logo=terraform)
![Kubernetes](https://img.shields.io/badge/Kubernetes-Orchestration-326CE5?logo=kubernetes)
![Docker](https://img.shields.io/badge/Docker-Containers-2496ED?logo=docker)
![Jenkins](https://img.shields.io/badge/Jenkins-CI/CD-D24939?logo=jenkins)
![License](https://img.shields.io/badge/License-MIT-green)

---
## 📌 Project Overview
This project demonstrates a complete end-to-end DevOps pipeline where infrastructure and application deployment are fully automated.

- CI/CD implemented using Jenkins  
- Infrastructure provisioned using Terraform  
- Application deployed on Amazon EKS  
- Secure access configured via IAM roles & policies  
- Application exposed using AWS Application Load Balancer (ALB)

---

## 🏗️ Architecture Overview

Developer → GitHub (SCM)
        ↓
     Jenkins Pipeline
        ↓
Terraform → AWS EKS Cluster
        ↓
Kubernetes Deployment
        ↓
Application exposed via ALB
        ↓
End User (Browser Access)

---

## ⚙️ Tech Stack

### 🚀 DevOps & Cloud
- AWS (EKS, IAM, ALB)
- Jenkins
- Terraform
- Kubernetes
- Docker

---

## 🚀 CI/CD Pipeline Design

### 🔹 1. Infrastructure CI Pipeline  
📄 jenkins-file.infraci

- terraform init  
- terraform plan  

### 🔹 2. Infrastructure CD Pipeline  
📄 jenkins-file.infracd

- terraform apply -auto-approve  

### 🔹 3. Application Deployment Pipeline  
📄 Jenkinsfile.app-deploy

- Build Docker image  
- Push image  
- Deploy to Kubernetes  
- Configure ALB  

### 🔹 4. Deployment Verification Pipeline  
📄 Jenkinsfile.verify-deployment

- kubectl get pods  
- kubectl get nodes  
- kubectl get svc  

---

## 🔐 IAM & Security

- IAM roles for EKS, nodes, Jenkins  
- OIDC provider enabled  
- Least privilege model applied  

---

## 🌐 Application Access

http://<ALB-DNS>

---

## 🧠 Key Features

- End-to-end CI/CD automation  
- Infrastructure as Code  
- Kubernetes deployment  
- Multi-pipeline architecture  
- Automated verification  

---

## 👨‍💻 Author

Jagdeep Sodhi
