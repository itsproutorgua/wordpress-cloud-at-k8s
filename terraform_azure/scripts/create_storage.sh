#!/bin/bash

RESOURCE_GROUP_NAME=tfstate
STORAGE_ACCOUNT_NAME=tfstatemondy2023
CONTAINER_NAME=tfstate

# Authenticate with Azure using environment variables
az login --service-principal -u $ARM_CLIENT_ID -p $ARM_CLIENT_SECRET --tenant $ARM_TENANT_ID

# Set the subscription context
az account set --subscription $ARM_SUBSCRIPTION_ID

 # Check if storage account exists
if  az storage account show --name $STORAGE_ACCOUNT_NAME --query id --output tsv >/dev/null 2>&1; then
echo "Storage already exist"
sleep 5s

else
# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location eastus2
# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS  --https-only true
# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME
sleep 30s
fi