
resource "azurerm_private_dns_resolver_inbound_endpoint" "this" {
  location                = var.location
  name                    = var.name
  private_dns_resolver_id = var.private_dns_resolver_id
  tags                    = var.tags
  dynamic "ip_configurations" {
    for_each = var.ip_configurations
    content {
      subnet_id = var.subnet_id
      private_ip_address = lookup(ip_configurations.value,"private_ip_address",null)
      private_ip_allocation_method = lookup(ip_configurations.value,"private_ip_allocation_method",null)
    }
  }
}

