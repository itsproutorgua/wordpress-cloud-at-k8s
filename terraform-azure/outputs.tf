output "kube_config" {
  value = azurerm_kubernetes_cluster.product.kube_config_raw

  sensitive = true
}

output "resource_group_name" {
  value = azurerm_resource_group.product.name
}