output "frontdoor_profile_id" {
  description = "The ID of the Front Door profile"
  value       = azurerm_cdn_frontdoor_profile.frontdoor_profile.id
}

output "frontdoor_profile_name" {
  description = "The name of the Front Door profile"
  value       = azurerm_cdn_frontdoor_profile.frontdoor_profile.name
}

output "frontdoor_profile_resource_guid" {
  description = "The resource GUID of the Front Door profile"
  value       = azurerm_cdn_frontdoor_profile.frontdoor_profile.resource_guid
}

# Multiple endpoints outputs
output "frontdoor_endpoints" {
  description = "Map of Front Door endpoints with their details"
  value = {
    for endpoint_name, endpoint in azurerm_cdn_frontdoor_endpoint.frontdoor_endpoints : endpoint_name => {
      id        = endpoint.id
      name      = endpoint.name
      host_name = endpoint.host_name
    }
  }
}

output "frontdoor_endpoint_ids" {
  description = "List of Front Door endpoint IDs"
  value       = [for endpoint in azurerm_cdn_frontdoor_endpoint.frontdoor_endpoints : endpoint.id]
}

output "frontdoor_endpoint_hostnames" {
  description = "List of Front Door endpoint hostnames"
  value       = [for endpoint in azurerm_cdn_frontdoor_endpoint.frontdoor_endpoints : endpoint.host_name]
}

# Multiple origin groups outputs
output "frontdoor_origin_groups" {
  description = "Map of Front Door origin groups with their details"
  value = {
    for group_name, group in azurerm_cdn_frontdoor_origin_group.frontdoor_origin_groups : group_name => {
      id   = group.id
      name = group.name
    }
  }
}

output "frontdoor_origin_group_ids" {
  description = "List of Front Door origin group IDs"
  value       = [for group in azurerm_cdn_frontdoor_origin_group.frontdoor_origin_groups : group.id]
}

# Multiple origins outputs
output "frontdoor_origins" {
  description = "Map of Front Door origins with their details"
  value = {
    for origin_name, origin in azurerm_cdn_frontdoor_origin.frontdoor_origins : origin_name => {
      id        = origin.id
      name      = origin.name
      host_name = origin.host_name
    }
  }
}

output "frontdoor_origin_ids" {
  description = "List of Front Door origin IDs"
  value       = [for origin in azurerm_cdn_frontdoor_origin.frontdoor_origins : origin.id]
}
