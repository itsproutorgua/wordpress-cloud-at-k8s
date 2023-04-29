#!/usr/bin/env bash

# Install Tekton CLI
curl -LO https://github.com/tektoncd/cli/releases/download/v0.20.0/tkn_0.20.0_Linux_x86_64.tar.gz
sudo tar xvzf tkn_0.20.0_Linux_x86_64.tar.gz -C /usr/local/bin/ tkn

# Install Tekton Pipelines
kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml

# Install Tekton Triggers
kubectl apply --filename https://storage.googleapis.com/tekton-releases/triggers/latest/release.yaml

# Install Tekton Dashboard
kubectl apply --filename https://storage.googleapis.com/tekton-releases/dashboard/latest/release.yaml