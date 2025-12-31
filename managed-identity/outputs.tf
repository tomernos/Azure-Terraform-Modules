output "managed_identity_id" {
  description = "ID of the created managed identity"
  value       = azurerm_user_assigned_identity.managed_identity.id
}

output "managed_identity_principal_id" {
  description = "Principal ID of the created managed identity"
  value       = azurerm_user_assigned_identity.managed_identity.principal_id
}

output "managed_identity_client_id" {
  description = "Client ID of the created managed identity"
  value       = azurerm_user_assigned_identity.managed_identity.client_id
} 