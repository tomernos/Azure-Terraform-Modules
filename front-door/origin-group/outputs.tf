output "id" {
  value = var.create ? azurerm_cdn_frontdoor_origin_group.this["this"].id : data.azurerm_cdn_frontdoor_origin_group.this["this"].id 
}
output "name" {
  value = var.create ? azurerm_cdn_frontdoor_origin_group.this["this"].name : data.azurerm_cdn_frontdoor_origin_group.this["this"].name
}
output "origins" {
  value = module.origns
}