output "id" {
  value = azurerm_storage_account.this.id 
}
output "name" {
  value = azurerm_storage_account.this.name 
}
output "location" {
  value = azurerm_storage_account.this.location 
}
output "primary_access_key" {
  value = azurerm_storage_account.this.primary_access_key 
  sensitive = true
}
output "secondary_access_key" {
  value = azurerm_storage_account.this.secondary_access_key 
  sensitive = true
}
output "primary_connection_string" {
  value = azurerm_storage_account.this.primary_connection_string 
  sensitive = true
}
output "secondary_connection_string" {
  value = azurerm_storage_account.this.secondary_connection_string 
  sensitive = true
}