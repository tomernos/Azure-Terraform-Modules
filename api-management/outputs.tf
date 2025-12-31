output "id" {
  value = azurerm_api_management.this.id 
}
output "name" {
  value = azurerm_api_management.this.name 
}
output "resource_group_name" {
  value = azurerm_api_management.this.resource_group_name 
}
output "additional_location" {
  value =  [for additional_location in azurerm_api_management.this.additional_location:
    {
      location = additional_location.location,
      capacity = additional_location.capacity,
      zones = additional_location.zones,
      gateway_regional_url = additional_location.gateway_regional_url,
      public_ip_addresses = additional_location.public_ip_addresses,
      public_ip_address_id = additional_location.public_ip_address_id,
      private_ip_addresses = additional_location.private_ip_addresses,
      virtual_network_configuration = additional_location.virtual_network_configuration,
      gateway_disabled = additional_location.gateway_disabled
    }
  ]
}
output "location" {
  value = azurerm_api_management.this.location 
}
output "gateway_url" {
  value = azurerm_api_management.this.gateway_url 
}
output "gateway_regional_url" {
  value = azurerm_api_management.this.gateway_regional_url 
}
output "identity" {
  value = azurerm_api_management.this.identity 
}
output "hostname_configuration" {
  value = azurerm_api_management.this.hostname_configuration 
}
output "management_api_url" {
  value = azurerm_api_management.this.management_api_url 
}
output "portal_url" {
  value = azurerm_api_management.this.portal_url 
}
output "developer_portal_url" {
  value = azurerm_api_management.this.developer_portal_url 
}
output "public_ip_addresses" {
  value = azurerm_api_management.this.public_ip_addresses 
}
output "public_ip_address_id" {
  value = azurerm_api_management.this.public_ip_address_id 
}
output "private_ip_addresses" {
  value = azurerm_api_management.this.private_ip_addresses 
}
output "publisher_name" {
  value = azurerm_api_management.this.publisher_name 
}
output "publisher_email" {
  value = azurerm_api_management.this.publisher_email 
}
output "scm_url" {
  value = azurerm_api_management.this.scm_url 
}
output "sku_name" {
  value = azurerm_api_management.this.sku_name 
}
output "tenant_access" {
  value = azurerm_api_management.this.tenant_access 
}
output "tags" {
  value = azurerm_api_management.this.tags 
}