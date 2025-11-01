#!/bin/bash
set -eux
apt-get update -y
apt-get install -y curl ca-certificates gnupg lsb-release
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--write-kubeconfig-mode 644 --disable traefik" sh -
ln -sf /usr/local/bin/kubectl /usr/bin/kubectl || true
curl -s https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
kubectl create namespace ingress-nginx || true
helm upgrade --install ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx \
  --set controller.service.type=NodePort \
  --set controller.service.nodePorts.http=80 \
  --set controller.service.nodePorts.https=443 \
  --set controller.hostNetwork=true \
  --set controller.dnsPolicy=ClusterFirstWithHostNet
kubectl create namespace cert-manager || true
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm upgrade --install cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --set installCRDs=true
