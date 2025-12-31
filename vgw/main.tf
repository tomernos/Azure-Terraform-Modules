resource "azurerm_virtual_network_gateway" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  type                = var.type
  dynamic "ip_configuration" {
    for_each = var.ip_configuration
    content {
      name                          = ip_configuration.value.name
      public_ip_address_id          = var.public_ip_address_id
      subnet_id                     = var.subnet_id
    }
  }
  enable_bgp        = var.enable_bgp
  dynamic "bgp_settings" {
    for_each = var.bgp_settings != null ? toset(["bgp_settings"]) : toset([])
    content {
      asn = lookup(var.bgp_settings, "asn", null)
      peer_weight = lookup(var.bgp_settings, "peer_weight", null)
      peering_addresses {
        ip_configuration_name = lookup(var.ip_configuration[0], "name", null)
        apipa_addresses = lookup(var.bgp_settings.peering_addresses, "apipa_addresses", [])
      }
    }
  }
  dynamic "vpn_client_configuration" {
    for_each = var.vpn_client_configuration != null ? toset(["vpn_client_configuration"]) : toset([])
    content {
      address_space = var.vpn_client_configuration.address_space
      aad_audience = lookup(var.vpn_client_configuration, "aad_audience", null)
      aad_tenant = lookup(var.vpn_client_configuration, "aad_tenant", null)
      aad_issuer = lookup(var.vpn_client_configuration, "aad_issuer", null)
      vpn_auth_types = lookup(var.vpn_client_configuration, "vpn_auth_types", null)
      vpn_client_protocols = lookup(var.vpn_client_configuration, "vpn_client_protocols", null)
    }
  }
  dynamic "custom_route" {
    for_each = var.custom_route != null ? toset(["custom_route"]) : toset([])
    content {
      address_prefixes = lookup(var.custom_route, "address_prefixes", null)
    }
  }
}

module "local_gateway" {
  source = "../local-network-gateway"
  for_each = var.local_gateway
  name = each.key
  resource_group_name = var.resource_group_name
  location = var.location
  address_space = [for vpc in each.value.address_space : vpc]
  gateway_address = each.value.gateway_address
  gateway_fqdn = lookup(each.value, "gateway_fqdn", null)
  tags = var.tags
  bgp_settings = lookup(each.value, "bgp_settings", null)
}

data "aws_ssm_parameter" "shared_key" {
  for_each = var.connections
  name = each.value.shared_key_secret_name
}

module "connection" {
  source = "../vpn-gateway-connection"
  for_each = var.connections
  name = each.key
  resource_group_name = var.resource_group_name
  location = var.location
  dpd_timeout_seconds = lookup(each.value, "dpd_timeout_seconds",null)
  type = each.value.type
  virtual_network_gateway_id = azurerm_virtual_network_gateway.this.id
  local_network_gateway_id = module.local_gateway[each.value.local_network_gateway_name].id
  shared_key = data.aws_ssm_parameter.shared_key[each.key].value
  tags = var.tags
}