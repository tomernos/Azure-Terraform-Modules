output "id" {
  value = var.create ? azurerm_web_application_firewall_policy.this["wafPolicy"].id : data.azurerm_web_application_firewall_policy.this.id
}
output "name" {
  value = var.create ? azurerm_web_application_firewall_policy.this["wafPolicy"].name : data.azurerm_web_application_firewall_policy.this.name
}
output "location" {
  value = var.create ? azurerm_web_application_firewall_policy.this["wafPolicy"].location : data.azurerm_web_application_firewall_policy.this.location
}
