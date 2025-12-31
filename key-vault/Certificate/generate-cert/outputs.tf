output "id" {
  value = azurerm_key_vault_certificate.this.id 
}
output "secret_id" {
  value = azurerm_key_vault_certificate.this.secret_id 
}
output "version" {
  value = azurerm_key_vault_certificate.this.version 
}
output "versionless_id" {
  value = azurerm_key_vault_certificate.this.versionless_id 
}
output "versionless_secret_id" {
  value = azurerm_key_vault_certificate.this.versionless_secret_id 
}
output "thumbprint" {
  value = azurerm_key_vault_certificate.this.thumbprint 
}
output "certificate_data" {
  value = azurerm_key_vault_certificate.this.certificate_data 
}
output "certificate_data_base64" {
  value = azurerm_key_vault_certificate.this.certificate_data_base64 
}