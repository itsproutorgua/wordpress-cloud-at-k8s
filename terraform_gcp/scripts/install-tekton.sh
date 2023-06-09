#!/bin/bash
# Install Tekton CLI
echo "1 ----- >Tekton CLI"
curl -LO https://github.com/tektoncd/cli/releases/download/v0.30.1/tektoncd-cli-0.30.1_Linux-64bit.deb
sudo dpkg -i ./tektoncd-cli-0.30.1_Linux-64bit.deb

# Install Tekton Pipelines
echo "2 ----- >Install Tekton Pipelines"
kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml

# Install Tekton Dashboard
echo "3 ----- >Install Tekton Dashboard"
kubectl apply --filename https://storage.googleapis.com/tekton-releases/dashboard/latest/release.yaml

# Install tasks from Tekton Hub
echo "4 ----- >Install tasks from Tekton Hub"
tkn hub install task git-clone && tkn hub install task buildah && tkn hub install task kubernetes-actions 

# Install Tekton Triggers
sleep 30
echo "5 ----- >Install Tekton Triggers"
kubectl apply --filename https://storage.googleapis.com/tekton-releases/triggers/latest/release.yaml

# Install Tekton Operators
echo "6 ----- >Install Tekton Operators"
kubectl apply -f https://storage.googleapis.com/tekton-releases/operator/latest/release.yaml

cat > regsecret.yaml << EOM
kind: Secret
apiVersion: v1
metadata:
  name: regsecret
  annotations:
    tekton.dev/docker-0: https://index.docker.io/
type: kubernetes.io/basic-auth
stringData:
    username: $DOCKER_USERNAME
    password: $DOCKER_PASSWORD
EOM

kubectl apply -f regsecret.yaml

echo "apply -f pipeline/"
kubectl apply -f pipeline/

echo "apply -f tekton/"
kubectl apply -f tekton/

kubectl create rolebinding pipeline-pvc --clusterrole=edit --serviceaccount=default:pipeline --namespace=default
kubectl create clusterrolebinding pipeline-admin --clusterrole=cluster-admin --serviceaccount=default:pipeline
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.0/deploy/static/provider/cloud/deploy.yaml

