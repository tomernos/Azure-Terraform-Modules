
output "id" {
  value = azurerm_private_dns_resolver.this.id 
}
output "outbound_endpoints" {
  value = module.outbound_endpoint
}