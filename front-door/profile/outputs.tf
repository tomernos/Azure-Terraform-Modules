output "id" {
  value = var.create ? azurerm_cdn_frontdoor_profile.this["this"].id : data.azurerm_cdn_frontdoor_profile.this["this"].id 
}
output "name" {
  value = var.create ? azurerm_cdn_frontdoor_profile.this["this"].id : data.azurerm_cdn_frontdoor_profile.this["this"].id 
}
output "custom_domains" {
  value = module.custom-domain
}
output "endpoints" {
  value = module.endpoints
}