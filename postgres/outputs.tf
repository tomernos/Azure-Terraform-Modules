
output "postgresql_server_id" {
  value = azurerm_postgresql_flexible_server.main.id
}

output "postgresql_server_name" {
  value = azurerm_postgresql_flexible_server.main.name
}

output "postgresql_server_fqdn" {
  value = azurerm_postgresql_flexible_server.main.fqdn
}