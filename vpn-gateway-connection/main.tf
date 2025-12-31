resource "azurerm_virtual_network_gateway_connection" "this" {
  name                               = var.name
  location                           = var.location
  resource_group_name                = var.resource_group_name
  type                               = var.type
  virtual_network_gateway_id         = var.virtual_network_gateway_id
  local_network_gateway_id           = var.type == "IPsec" ? var.local_network_gateway_id : null
  peer_virtual_network_gateway_id    = var.type == "Vnet2Vnet" ? var.peer_virtual_network_gateway_id : null
  express_route_circuit_id           = var.type == "ExpressRoute" ? var.express_route_circuit_id : null
  local_azure_ip_address_enabled     = var.local_azure_ip_address_enabled
  shared_key                         = var.shared_key
  authorization_key                  = var.authorization_key
  dpd_timeout_seconds                = var.dpd_timeout_seconds
  routing_weight                     = var.routing_weight
  connection_mode                    = var.connection_mode
  connection_protocol                = var.connection_protocol
  enable_bgp                         = var.enable_bgp
  express_route_gateway_bypass       = var.express_route_gateway_bypass
  egress_nat_rule_ids                = var.egress_nat_rule_ids
  ingress_nat_rule_ids               = var.ingress_nat_rule_ids
  use_policy_based_traffic_selectors = var.ipsec_policy != null && var.use_policy_based_traffic_selectors == true ? var.use_policy_based_traffic_selectors : false
  tags                               = var.tags


  dynamic "custom_bgp_addresses" {
    for_each = var.type == "IPSec" && var.custom_bgp_addresses != null ? toset(["custom_bgp_addresses"]) : toset([])
    content {
      primary   = var.custom_bgp_addresses.primary
      secondary = var.custom_bgp_addresses.secondary
    }
  }

  dynamic "traffic_selector_policy" {
    for_each = var.traffic_selector_policy != null ? toset(["traffic_selector_policy"]) : toset([])
    content {
      local_address_cidrs  = var.traffic_selector_policy.local_address_cidrs
      remote_address_cidrs = var.traffic_selector_policy.remote_address_cidrs
    }
  }

  dynamic "ipsec_policy" {
    for_each = var.use_policy_based_traffic_selectors == true && var.ipsec_policy != null ? toset(["ipsec_policy"]) : toset([])
    content {
      dh_group         = var.ipsec_policy.dh_group
      ike_encryption   = var.ipsec_policy.ike_encryption
      ike_integrity    = var.ipsec_policy.ike_integrity
      ipsec_encryption = var.ipsec_policy.ipsec_encryption
      ipsec_integrity  = var.ipsec_policy.ipsec_integrity
      pfs_group        = var.ipsec_policy.pfs_group
      sa_datasize      = var.ipsec_policy.sa_datasize
      sa_lifetime      = var.ipsec_policy.sa_lifetime
    }
  }
  lifecycle {
    ignore_changes = [
      shared_key,
    ]
  }
}


