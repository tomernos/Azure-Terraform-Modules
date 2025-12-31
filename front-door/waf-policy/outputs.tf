output "id" {
  value = var.create ? azurerm_cdn_frontdoor_firewall_policy.this["this"].id : data.azurerm_cdn_frontdoor_firewall_policy.this["this"].id 
}
output "name" {
  value = var.create ? azurerm_cdn_frontdoor_firewall_policy.this["this"].name : data.azurerm_cdn_frontdoor_firewall_policy.this["this"].name
}