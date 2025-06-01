
output "vnet_ids" {
  description = "Map of VNET IDs"
  value       = { for k, v in azurerm_virtual_network.this : k => v.id }
}

output "vnet_names" {
  description = "Map of VNET names"
  value       = { for k, v in azurerm_virtual_network.this : k => v.name }
}

output "subnet_ids" {
  description = "Map of Subnet IDs"
  value       = { for k, v in azurerm_subnet.this : k => v.id }
}

output "subnet_names" {
  description = "Map of Subnet Names"
  value       = { for k, v in azurerm_subnet.this : k => v.name }
}

output "resource_group_names" {
  description = "Map of Resource Group Names"
  value       = { for k, v in azurerm_resource_group.this : k => v.name }
}