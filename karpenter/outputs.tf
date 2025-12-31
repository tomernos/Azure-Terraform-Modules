output "karpenter_identity_principal_id" {
  description = "Principal ID of the Karpenter managed identity"
  value       = azurerm_user_assigned_identity.karpenter.principal_id
}

output "karpenter_identity_client_id" {
  description = "Client ID of the Karpenter managed identity"
  value       = azurerm_user_assigned_identity.karpenter.client_id
}

output "karpenter_identity_id" {
  description = "Resource ID of the Karpenter managed identity"
  value       = azurerm_user_assigned_identity.karpenter.id
}