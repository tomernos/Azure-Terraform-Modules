output "cluster_name" {
  value = try(azurerm_kubernetes_cluster.aks.name, null)
}

output "kube_config_raw" {
  value     = try(azurerm_kubernetes_cluster.aks.kube_config_raw, null)
  sensitive = true
}

output "cluster_identity" {
  value = try(azurerm_kubernetes_cluster.aks.identity[0].principal_id, null)
}