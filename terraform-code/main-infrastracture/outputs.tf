# Output values from the network module
output "vnet_ids" {
  description = "IDs of all virtual networks"
  value       = module.network.vnet_ids
}

output "vnet_names" {
  description = "Names of all virtual networks"
  value       = module.network.vnet_names
}

output "subnet_ids" {
  description = "IDs of all subnets"
  value       = module.network.subnet_ids
}

output "subnet_names" {
  description = "Names of all subnets"
  value       = module.network.subnet_names
}

output "resource_group_names" {
  description = "Names of all resource groups"
  value       = module.network.resource_group_names
}