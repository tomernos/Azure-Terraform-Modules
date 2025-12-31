output "id" {
  value = var.create ? azurerm_application_insights.this["application_insights"].id : data.azurerm_application_insights.this.id
}
output "app_id" {
  value = var.create ? azurerm_application_insights.this["application_insights"].app_id : data.azurerm_application_insights.this.app_id
}
output "location" {
  value = var.create ? azurerm_application_insights.this["application_insights"].location : data.azurerm_application_insights.this.location
}
output "name" {
  value = var.create ? azurerm_application_insights.this["application_insights"].name : data.azurerm_application_insights.this.name
}
output "connection_string" {
  value = var.create ? azurerm_application_insights.this["application_insights"].connection_string : data.azurerm_application_insights.this.connection_string
}
