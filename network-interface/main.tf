resource "azurerm_network_interface" "this" { 
  name                = var.name
  location            = var.location 
  resource_group_name = var.resource_group_name
  accelerated_networking_enabled = var.accelerated_networking_enabled
  dynamic "ip_configuration" {
    for_each = var.ip_configuration
    content {
      name = ip_configuration.key
      subnet_id                     = var.subnet_id
      private_ip_address_allocation = lookup(ip_configuration.value,"private_ip_address_allocation", var.private_ip_address_allocation)
    }
  }
}
