resource "azurerm_private_endpoint" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  custom_network_interface_name = var.custom_network_interface_name

  dynamic "private_dns_zone_group" {
    for_each = var.private_dns_zone_group != null ? toset(["private_dns_zone_group"]) : toset([])
    content {
      name = var.private_dns_zone_group.name
      private_dns_zone_ids = var.private_dns_zone_group.private_dns_zone_ids
    }
  }
  private_service_connection {
    name = var.private_service_connection.name
    is_manual_connection = var.private_service_connection.is_manual_connection
    private_connection_resource_id = lookup(var.private_service_connection, "private_connection_resource_id", null)
    private_connection_resource_alias = lookup(var.private_service_connection, "private_connection_resource_alias", null)
    subresource_names = lookup(var.private_service_connection, "subresource_names", null)
    request_message = lookup(var.private_service_connection, "request_message", null)
  }
  dynamic "ip_configuration" {
    for_each = var.ip_configuration
    content {
      name = ip_configuration.key
      private_ip_address = ip_configuration.value.private_ip_address
      subresource_name = lookup(ip_configuration.value, "subresource_name", null)
      member_name = lookup(ip_configuration.value, "member_name", null)
    }
  }
}