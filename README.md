🚀 SprintBoard — SaaS Project Team Tracker (Cloud-Native Deployment)
A full-stack project management and team tracking platform deployed on AWS using Terraform, K3s (Lightweight Kubernetes), and complete Observability Stack (Prometheus, Grafana, Loki).
________________________________________

[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
![Terraform](https://img.shields.io/badge/Terraform-IaC-623CE4?logo=terraform)
![AWS](https://img.shields.io/badge/AWS-Deployed-232F3E?logo=amazon-aws)
![K3s](https://img.shields.io/badge/Kubernetes-K3s-326CE5?logo=kubernetes)
![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?logo=docker)
![Prometheus](https://img.shields.io/badge/Prometheus-Metrics-E6522C?logo=prometheus)
![Grafana](https://img.shields.io/badge/Grafana-Dashboard-F46800?logo=grafana)
![FastAPI](https://img.shields.io/badge/FastAPI-Backend-009688?logo=fastapi)
![React](https://img.shields.io/badge/React-Frontend-61DAFB?logo=react)
![MySQL](https://img.shields.io/badge/MySQL-RDS-4479A1?logo=mysql)

________________________________________

🧬 Project Overview
SprintBoard is a cloud-native SaaS platform that helps teams manage their projects, track sprints, and visualize progress — similar to tools like Jira or Trello.
This deployment demonstrates an end-to-end DevOps pipeline including: - Infrastructure as Code (Terraform) - Containerized microservices (FastAPI backend, React frontend) - Deployment on K3s (Kubernetes) - Ingress-based routing - Observability via Prometheus + Grafana + Loki - Secure AWS-managed resources (RDS, VPC, IAM, ECR)
________________________________________
🔗 Architecture
                      ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
                      │                                               AWS Cloud (ap-south-1)                                           │
                      │                                                                                                                │
                      │     ┌────────────────────────────────────────────────────────────────────────────────────────────────────┐     │
                      │     │                                           VPC (10.0.0.0/16)                                        │     │
                      │     │ ┌────────────────────────────────────────────────────────────────────────────────────────────────┐ │     │
                      │     │ │                                         Public Subnet (A)                                      │ │     │
                      │     │ │ ┌────────────────────────────────────────────────────────────────────────────────────────────┐ │ │     │
                      │     │ │ │                                        EC2 (K3s Master)                                    │ │ │     │
                      │     │ │ └───────────────────────────────────────────────┬────────────────────────────────────────────┘ │ │     │
                      │     │ └─────────────────────────────────────────────────┼──────────────────────────────────────────────┘ │     │
                      │     │                                                   │                                                │     │
                      │     │ ┌─────────────────────────────────────────────────┴──────────────────────────────────────────────┐ │     │
                      │     │ │                                         Private Subnets A/B                                    │ │     │
                      │     │ │                                         (RDS MySQL Database)                                   │ │     │
                      │     │ └────────────────────────────────────────────────────────────────────────────────────────────────┘ │     │
                      │     └────────────────────────────────────────────────────────────────────────────────────────────────────┘     │
                      │                                                                                                                │
                      │                                               Ingress → NGINX → Services                                       │
                      │                                                  / → Frontend (React)                                          │
                      │                                                 /api → FastAPI Backend                                         │
                      │                                              /grafana → Grafana Dashboard                                      │
                      └────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘


               ┌────────────────────────────┐
               │        AWS Cloud           │
               │       (ap-south-1)         │
               └────────────┬───────────────┘
                            │
                    ┌───────┴──────────────┐
                    │   VPC (10.0.0.0/16)  │
                    └───────┬──────────────┘
                            │
          ┌─────────────────┴──────────────────┐
          │                                    │
 ┌────────┴────────┐                 ┌─────────┴───────────┐
 │ Public Subnet A │                 │ Private Subnets A/B │
 │ (10.0.1.0/24)   │                 │ (10.0.11.0/24,      │
 │                 │                 │  10.0.12.0/24)      │
 └──────┬──────────┘                 └─────────┬───────────┘
        │                                      │
 ┌──────┴──────────┐                    ┌──────┴───────────┐
 │ EC2 (K3s Node)  │                    │ RDS MySQL DB     │
 │ NGINX Ingress,  │                    │ Private Endpoint │
 │ FastAPI, React  │                    └──────────────────┘
 │ Prometheus,     │
 │ Grafana, Loki   │
 └──────┬──────────┘
        │
        ▼
  Internet Gateway 🌍

Ingress Routing:
  • `/` → React Frontend  
  • `/api` → FastAPI Backend  
  • `/grafana` → Grafana Dashboard

________________________________________
🧱 Infrastructure Setup (Terraform)
Modules: - infra/terraform/network: Creates VPC, subnets, route tables, SGs
- infra/terraform/compute: Provisions EC2 (K3s master node)
- infra/terraform/data: Deploys RDS MySQL database
Key Resources: - ✅ VPC with 2 public and 2 private subnets (multi-AZ) - ✅ Internet Gateway, NAT, and Route Tables - ✅ Security Groups for EC2, RDS - ✅ EC2 instance (Ubuntu 22.04) running K3s - ✅ RDS MySQL (private network) - ✅ IAM roles and key pairs
Provisioning Commands:
terraform init
terraform validate
terraform plan -var-file=dev.tfvars
terraform apply -var-file=dev.tfvars
________________________________________
☸️ K3s (Lightweight Kubernetes)
Installed Automatically via user-data script:
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--write-kubeconfig-mode 644 --disable traefik" sh -
Deployments:
Component	Namespace	Type	Status
FastAPI Backend	sprintboard	Deployment + Service	✅
React Frontend	sprintboard	Deployment + Service	✅
NGINX Ingress	ingress-nginx	Helm Release	✅
Access Endpoints: - http://<EC2_PUBLIC_IP>/ → Frontend
- http://<EC2_PUBLIC_IP>/api/healthz → API health
- http://<EC2_PUBLIC_IP>/grafana → Grafana Dashboard
________________________________________
🔐 Secrets Management
Secret	Description	Stored In
db-credentials	MySQL username/password	Kubernetes Secret
ecr-creds	AWS ECR Docker pull secret	Kubernetes Secret
________________________________________
📊 Observability Stack (Helm)
Namespace: observability
Components:
Tool	Purpose	Helm Chart
Prometheus	Metrics collection	prometheus-community/kube-prometheus-stack
Grafana	Visualization dashboard	grafana/grafana
Loki	Centralized logging	grafana/loki
Promtail	Log collection from pods	grafana/promtail
Command:
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm install monitoring prometheus-community/kube-prometheus-stack -n observability
________________________________________
🧮 Tech Stack
Category	Tools
Cloud	AWS (VPC, EC2, ECR, IAM, RDS)
IaC	Terraform
Containerization	Docker
Orchestration	K3s (Kubernetes)
CI/CD	GitHub Actions (future-ready)
Monitoring	Prometheus, Grafana, Loki
Backend	Python FastAPI
Frontend	React.js
DB	MySQL (AWS RDS)
________________________________________
🧠 Key Highlights
✅ Automated Infrastructure provisioning with Terraform
✅ Lightweight Kubernetes (K3s) cluster setup
✅ Secure private RDS + public EC2 design
✅ NGINX Ingress routing for multiple services
✅ Complete Observability (Metrics + Logs)
✅ ECR integration for image pulls
✅ Ready for CI/CD extension via GitHub Actions
________________________________________
🗾 Commands Summary
Step	Command
Init Terraform	terraform init
Validate config	terraform validate
Plan infra	terraform plan -var-file=dev.tfvars
Apply infra	terraform apply -var-file=dev.tfvars
Connect EC2	ssh -i ~/.ssh/id_ed25519 ubuntu@<public-ip>
View nodes	kubectl get nodes -o wide
Deploy app	kubectl apply -f k8s/apps/
Check ingress	kubectl get ingress -A
Access Grafana	http://<ec2-public-ip>/grafana
________________________________________
🧩 Future Enhancements
•	☁️ Route53 custom domain integration

•	🔒 TLS via cert-manager + Let’s Encrypt

•	🧠 CI/CD pipeline using GitHub Actions + Terraform Cloud

•	🚀 Horizontal scaling via K3s agent nodes
________________________________________
🧑‍💻 Author
👋 Akash K
AWS Certified Cloud Practitioner | System Engineer
💼 GitHub: [Akash-k27](https://github.com/Akash-k27)
🔗 LinkedIn: [linkedin.com/in/akash-k-728a16207](https://www.linkedin.com/in/akash-k-728a16207/)
________________________________________
🏁 Version
v1.0.0 — Production-ready cloud-native deployment (Terraform + K3s + Observability)
________________________________________
