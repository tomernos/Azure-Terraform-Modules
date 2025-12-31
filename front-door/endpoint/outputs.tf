output "id" {
  value = var.create ? azurerm_cdn_frontdoor_endpoint.this["this"].id : data.azurerm_cdn_frontdoor_endpoint.this["this"].id 
}
output "host_name" {
  value = var.create ? azurerm_cdn_frontdoor_endpoint.this["this"].host_name : data.azurerm_cdn_frontdoor_endpoint.this["this"].host_name
}