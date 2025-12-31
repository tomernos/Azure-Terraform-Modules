output "id" {
  value = var.create ? azurerm_cdn_frontdoor_rule_set.this["this"].id : data.azurerm_cdn_frontdoor_rule_set.this["this"].id 
}
output "name" {
  value = var.create ? azurerm_cdn_frontdoor_rule_set.this["this"].id : data.azurerm_cdn_frontdoor_rule_set.this["this"].id 
}