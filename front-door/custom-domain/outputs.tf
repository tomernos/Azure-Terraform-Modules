output "id" {
  value = var.create ? azurerm_cdn_frontdoor_custom_domain.this["this"].id : data.azurerm_cdn_frontdoor_custom_domain.this["this"].id 
}
output "name" {
  value = var.create ? azurerm_cdn_frontdoor_custom_domain.this["this"].name : data.azurerm_cdn_frontdoor_custom_domain.this["this"].name
}
output "validation_token" {
  value = var.create ? azurerm_cdn_frontdoor_custom_domain.this["this"].validation_token : data.azurerm_cdn_frontdoor_custom_domain.this["this"].validation_token
}