# Create a resource group
resource "azurerm_resource_group" "product" {
  name     = "product"
  location = var.resource_group_location
}
#asd
resource "azurerm_network_security_group" "product" {
  name                = "product-security-group"
  location            = azurerm_resource_group.product.location
  resource_group_name = azurerm_resource_group.product.name

  security_rule {
    name                       = "azure-team"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "dev"
  }
}

# Create public ip
resource "azurerm_public_ip" "product" {
  name                = "PublicIPForLB"
  location            = azurerm_resource_group.product.location
  resource_group_name = azurerm_resource_group.product.name
  allocation_method   = "Static"
}

# Create load balancer
resource "azurerm_lb" "product" {
  name                = "LoadBalancer"
  location            = azurerm_resource_group.product.location
  resource_group_name = azurerm_resource_group.product.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.product.id
  }
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "product" {
  name                = "product-network"
  resource_group_name = azurerm_resource_group.product.name
  location            = azurerm_resource_group.product.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_kubernetes_cluster" "product" {
  name                = var.cluster_name
  location            = azurerm_resource_group.product.location
  resource_group_name = azurerm_resource_group.product.name
  dns_prefix          = var.cluster_name
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name       = "default"
    node_count = var.agent_count
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

resource "local_file" "kubeconfig" {
  filename = "${path.module}/kubeconfig"
  content  = azurerm_kubernetes_cluster.product.kube_config_raw
}
