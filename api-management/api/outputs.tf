output "id" {
  value = var.create ? azurerm_api_management_api.this["api"].id : data.azurerm_api_management_api.this.id
}
output "name" {
  value = var.create ? azurerm_api_management_api.this["api"].name : data.azurerm_api_management_api.this.name
}
output "api_management_name" {
  value = var.create ? azurerm_api_management_api.this["api"].api_management_name : data.azurerm_api_management_api.this.api_management_name
}
output "resource_group_name" {
  value = var.create ? azurerm_api_management_api.this["api"].resource_group_name : data.azurerm_api_management_api.this.resource_group_name
}
output "revision" {
  value = var.create ? azurerm_api_management_api.this["api"].revision : data.azurerm_api_management_api.this.revision
}
output "description" {
  value = var.create ? azurerm_api_management_api.this["api"].description : data.azurerm_api_management_api.this.description
}
output "display_name" {
  value = var.create ? azurerm_api_management_api.this["api"].display_name : data.azurerm_api_management_api.this.display_name
}
output "is_current" {
  value = var.create ? azurerm_api_management_api.this["api"].is_current : data.azurerm_api_management_api.this.is_current
}
output "is_online" {
  value = var.create ? azurerm_api_management_api.this["api"].is_online : data.azurerm_api_management_api.this.is_online
}
output "path" {
  value = var.create ? azurerm_api_management_api.this["api"].path : data.azurerm_api_management_api.this.path
}
output "protocols" {
  value = var.create ? azurerm_api_management_api.this["api"].protocols : data.azurerm_api_management_api.this.protocols
}
output "service_url" {
  value = var.create ? azurerm_api_management_api.this["api"].service_url : data.azurerm_api_management_api.this.service_url
}
output "subscription_key_parameter_names" {
  value = var.create ? azurerm_api_management_api.this["api"].subscription_key_parameter_names : data.azurerm_api_management_api.this.subscription_key_parameter_names
}
output "subscription_required" {
  value = var.create ? azurerm_api_management_api.this["api"].subscription_required : data.azurerm_api_management_api.this.subscription_required
}
output "version" {
  value = var.create ? azurerm_api_management_api.this["api"].version : data.azurerm_api_management_api.this.version
}
output "version_set_id" {
  value = var.create ? azurerm_api_management_api.this["api"].version_set_id : data.azurerm_api_management_api.this.version_set_id
}