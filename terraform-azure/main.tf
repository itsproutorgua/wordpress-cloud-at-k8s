resource "azurerm_resource_group" "aks-rg" {
  name     = var.resource_group_name
  location = var.location
}
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  kubernetes_version  = var.kubernetes_version
  location            = var.location
  resource_group_name = azurerm_resource_group.aks-rg.name
  dns_prefix          = var.cluster_name
  default_node_pool {
    name                = "system"
    node_count          = var.system_node_count
    vm_size             = "Standard_DS2_v2"
    type                = "VirtualMachineScaleSets"
    enable_auto_scaling = false
  }

  identity {
    type = "SystemAssigned"
  }
}
resource "local_file" "kubeconfig" {
  filename = "${path.module}/kubeconfig"
  content  = azurerm_kubernetes_cluster.aks.kube_config_raw
}
# Create MySql Server 
resource "azurerm_mysql_server" "aks-bd" {
  name                = "mysql-wpmax"
  location            = azurerm_resource_group.aks-rg.location
  resource_group_name = azurerm_resource_group.aks-rg.name

  administrator_login          = "mysqladmin"
  administrator_login_password = "1-qwerty"

  sku_name   = "B_Gen5_2"
  storage_mb = 5120
  version    = "5.7"

  auto_grow_enabled                 = true
  backup_retention_days             = 30
  geo_redundant_backup_enabled      = false
  infrastructure_encryption_enabled = false
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = false
  ssl_minimal_tls_version_enforced  = "TLSEnforcementDisabled"
}
resource "azurerm_mysql_firewall_rule" "aks-bd_sprout" {
  name                = "AllowAllIPs"
  resource_group_name = azurerm_resource_group.aks-rg.name
  server_name         = azurerm_mysql_server.aks-bd.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}
  # Create public ip
  resource "azurerm_public_ip" "aks-pip" {
    name                = "PublicIPForLB"
    location            = azurerm_resource_group.aks-rg.location
    resource_group_name = azurerm_resource_group.aks-rg.name
    allocation_method   = "Static"
  }

  # Create load balancer
  resource "azurerm_lb" "aks-lb" {
    name                = "LoadBalancer"
    location            = azurerm_resource_group.aks-rg.location
    resource_group_name = azurerm_resource_group.aks-rg.name
    frontend_ip_configuration {
      name                 = "LoadBalancer_lb_public_ip"
      public_ip_address_id = azurerm_public_ip.aks-pip.id
  }
  }
  # Create DNS record
  resource "azurerm_dns_zone" "aks-dns-zone" {
    name                = "wp-team.pp.ua"
    resource_group_name = azurerm_resource_group.aks-rg.name
  }

resource "azurerm_dns_cname_record" "aks-dns-zone" {
  name                = "wp-team.pp.ua"
  zone_name           = azurerm_dns_zone.aks-dns-zone.name
  resource_group_name = azurerm_resource_group.aks-rg.name
  ttl                 = 300
  record              = "wp-team.pp.ua"
}
resource "azurerm_dns_a_record" "a_record" {
  name                = azurerm_dns_zone.aks-dns-zone.name
  zone_name           = azurerm_dns_zone.aks-dns-zone.name
  resource_group_name = azurerm_resource_group.aks-rg.name
  ttl                 = 300
  target_resource_id  = azurerm_public_ip.aks-pip.id
}


