terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.95.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "product" {
  name     = "product-resources"
  location = "East US"
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "product" {
  name                = "product-network"
  resource_group_name = azurerm_resource_group.product.name
  location            = azurerm_resource_group.product.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_kubernetes_cluster" "product" {
  name                = "product-aks1"
  location            = azurerm_resource_group.product.location
  resource_group_name = azurerm_resource_group.product.name
  dns_prefix          = "productaks1"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.product.kube_config.0.client_certificate
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.product.kube_config_raw

  sensitive = true
}