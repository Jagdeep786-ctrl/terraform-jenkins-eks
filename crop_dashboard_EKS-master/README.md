# 🌾 Crop Dashboard Deployment on AWS EKS

## 📌 Project Overview
This project demonstrates a **production-grade deployment** of a Crop Price Dashboard application on **Amazon EKS (Elastic Kubernetes Service)** using a **three-tier architecture**.

It covers complete DevOps lifecycle:
- Kubernetes manifests (Deployment, Service, PV, PVC, ConfigMap, Ingress)
- AWS infrastructure setup (EKS, Node Groups, IAM, ALB)
- Monitoring with Prometheus, Grafana, and Node Exporter
- Application exposure via AWS Application Load Balancer (ALB)

## 🏗️ Architecture Diagram

User --> Frontend
Frontend --> APIGateway

APIGateway --> DataService
APIGateway --> TrendService
APIGateway --> WriteService

DataService --> MySQL[(MySQL)]
TrendService --> ML[(ML Model)]

APIGateway --> Response
Response --> Frontend
Frontend --> Chart[Chart Visualization]

## ⚙️ Tech Stack

### 🚀 Backend & Services
- Node.js (API Gateway & Write Service)
- Python (Trend Service - ML Predictions)
- MySQL (Data Service)

### 🌐 Frontend
- React.js (Chart visualization)

### ☁️ DevOps & Cloud
- AWS EKS
- Kubernetes
- Docker
- Helm
- AWS ALB (Ingress)

### 📊 Monitoring 
- Prometheus
- Grafana
- Node Exporter


## 🚀 Deployment Workflow

### Create Kubernetes Resources

- Deployment & Service YAMLs
- ConfigMaps
- Persistent Volume (PV)
- Persistent Volume Claim (PVC)
- Ingress (ALB)

```bash

kubectl apply -f namespace.yaml
kubectl apply -f . -n stock
kubectl create configmap mysql-initdb --from-file=init.sql=./db/init.sql -n stock

## 🚀AWS EKS Setup

### 🔹 Create EKS Cluster

```bash
eksctl create cluster \
--name crop-dashboard-newcluster \
--region us-east-1 \
--nodegroup-name standard-workers \
--node-type t3.medium \
--nodes 2 \
--nodes-min 2 \
--nodes-max 2 \
--managed

### 🔹 Configure kubectl

```bash
aws eks --region us-east-1 update-kubeconfig \
--name crop-dashboard-newcluster

### 🔹 Associate IAM OIDC Provider

```bash
eksctl utils associate-iam-oidc-provider \
--region us-east-1 \
--cluster crop-dashboard-newcluster \
--approve

##🌐 ALB Ingress Setup

### 🔹 Download IAM Policy

```bash
curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/install/iam_policy.json


### 🔹 Create IAM Policy

```bash
aws iam create-policy \
--policy-name AWSLoadBalancerControllerIAMPolicy \
--policy-document file://iam_policy.json

### 🔹Create IAM Service Account

```bash
eksctl create iamserviceaccount \
--cluster crop-dashboard-newcluster \
--namespace kube-system \
--name aws-load-balancer-controller \
--attach-policy-arn arn:aws:iam::<ACCOUNT_ID>:policy/AWSLoadBalancerControllerIAMPolicy \
--approve

### 🔹Install ALB Controller

```bash
helm repo add eks https://aws.github.io/eks-charts
helm repo update

helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
-n kube-system \
--set clusterName=crop-dashboard-newcluster \
--set serviceAccount.create=false \
--set serviceAccount.name=aws-load-balancer-controller

### 🔹Verify ALB

```bash
kubectl get ingress

```bash
Access app via:  http://<ALB-DNS>

## 📊 Monitoring Setup

### 🔹 Install Prometheus & Grafana

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm install monitoring prometheus-community/kube-prometheus-stack

### 🔹Install Node Exporter

```bash
kubectl apply -f https://raw.githubusercontent.com/prometheus/node_exporter/master/examples/node-exporter-daemonset.yaml
    
### 🔹 Access Grafana

```bash
kubectl patch svc prometheus-grafana -n monitoring -p '{"spec": {"type": "LoadBalancer"}}'

  kubectl get svc -n monitoring

```bash
kubectl get svc -n monitoring

### 🔹  Grafana Username

admin

### 🔹  Grafana Password

```bash
kubectl get secret --namespace monitoring prometheus-grafana -o jsonpath="{.data.admin-password}" | base64 --decode

### 🔹  Expose Grafana via ALB


##  🧹 Cleanup

```bash
kubectl delete -f . -n namespace
eksctl delete cluster \
--name crop-dashboard-newcluster \
--region us-east-1




## 💬 Honest Interview Tip

If interviewer asks this project:

👉 Say this:

“I designed and deployed a microservices-based application on AWS EKS with ALB ingress and implemented full monitoring using Prometheus and Grafana.”



## 👨‍💻** Author**

Jagdeep Sodhi

