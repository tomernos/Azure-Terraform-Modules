output "id" {
  value = var.create ? azurerm_service_plan.this["service_plan"].id : data.azurerm_service_plan.this.id
}
output "name" {
  value = var.create ? azurerm_service_plan.this["service_plan"].name : data.azurerm_service_plan.this.name
}
output "location" {
  value = var.create ? azurerm_service_plan.this["service_plan"].location : data.azurerm_service_plan.this.location
}
output "resource_group_name" {
  value = var.create ? azurerm_service_plan.this["service_plan"].resource_group_name : data.azurerm_service_plan.this.resource_group_name
}
output "sku_name" {
  value = var.create ? azurerm_service_plan.this["service_plan"].sku_name : data.azurerm_service_plan.this.sku_name
}
output "os_type" {
  value = var.create ? azurerm_service_plan.this["service_plan"].os_type : data.azurerm_service_plan.this.os_type
}