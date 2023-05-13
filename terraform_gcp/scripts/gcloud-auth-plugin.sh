 #!/bin/bash

REPO_URL="https://packages.cloud.google.com/apt"
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] $REPO_URL cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list >/dev/null
sudo wget -q https://packages.cloud.google.com/apt/doc/apt-key.gpg -O /usr/share/keyrings/cloud.google.gpg

sudo apt-get update -y
sudo apt-get install -y google-cloud-sdk-gke-gcloud-auth-plugin