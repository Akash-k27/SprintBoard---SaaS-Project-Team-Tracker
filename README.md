# SprintBoard

Manual-first **DevOps & Cloud** project that ships a tiny app (static NGINX page + minimal FastAPI) to focus on **AWS, Kubernetes, security, observability, and cost control**. App stays intentionally small so you can master infra.

## Why this repo?
- Practice real **production-style** infra on a budget (k3s on EC2, TLS, Ingress, ECR, RDS later)
- Learn-by-doing: do it **manually first**, then codify with **Terraform/Helm/Argo CD** later
- Interview-ready runbooks and scenarios

## Initial scope (v0.0.1-manual)
- k3s on EC2 (single node), NGINX Ingress, cert-manager (DNS-01 with Route53)
- Public HTTPS endpoint: `app.<your-domain>`
- Minimal services:
  - **frontend**: NGINX serving a static “SprintBoard is Live” page
  - **api**: FastAPI with `/healthz` and `/echo`

## Repository layout
- sprintboard/
- apps/
- api/ # tiny FastAPI (added in next step)
- frontend/ # static index.html for NGINX (next step)
- k8s/
- apps/ # deployments/services/ingress (next step)
- ops/ # ingress-nginx, cert-manager, etc. (later)
- infra/ # Terraform (added after manual)
- docs/ # playbooks, diagrams, runbooks
- .github/workflows/ # CI later



---

## 🗺️ Roadmap (Version Tags)

| Tag | Milestone |
|-----|------------|
| `v0.0.1-manual` | Manual setup (current version) |
| `v0.1.0-iac-network` | VPC, Subnets, SGs in Terraform |
| `v0.2.0-iac-data` | RDS + Secrets Manager CSI |
| `v0.3.0-gitops` | Helm + Argo CD (App-of-Apps) |
| `v0.4.0-observability` | kube-prom stack, Loki, alerts |

---

## 🧠 Key Learning Areas

- AWS networking (VPC, subnets, SGs)
- k3s cluster setup on EC2
- TLS with cert-manager (DNS-01 Route53)
- Container image pipeline (ECR push + deploy)
- Monitoring & logging (Prometheus, Grafana, Loki)
- Security hardening (Kyverno, IAM OIDC, WAF)
- Cost optimization (spot instances, lifecycle, log retention)

---


## 🪪 License

MIT License  
Copyright (c) 2025
