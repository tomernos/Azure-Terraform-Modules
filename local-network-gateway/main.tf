resource "azurerm_local_network_gateway" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.address_space
  gateway_address     = var.gateway_fqdn != null ? null : var.gateway_address
  gateway_fqdn        = var.gateway_address != null ? null : var.gateway_fqdn
  tags                = var.tags

  dynamic "bgp_settings" {
    for_each = var.bgp_settings != null ? toset(["bgp_settings"]) : toset([])
    content {
      asn                 = var.bgp_settings.asn
      bgp_peering_address = var.bgp_settings.bgp_peering_address
      peer_weight         = var.bgp_settings.peer_weight
    }
  }
}
