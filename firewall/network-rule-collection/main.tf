

resource "azurerm_firewall_network_rule_collection" "fw-net-rule" {
  name                = lower(format("fw-net-rule-%s-${var.name}-${var.location}", each.key))
  azure_firewall_name = var.azure_firewall_name
  resource_group_name = var.resource_group_name
  priority            = 100 * (var.idx + 1)
  action              = var.action

  dynamic "rule" {
    for_each              = var.rules
    content {
      name                  = rule.key
      description           = lookup(rule.value, "description",null)
      source_addresses      = rule.value.source_addresses
      destination_ports     = rule.value.destination_ports
      destination_addresses = rule.value.destination_addresses
      destination_fqdns     = lookup(rule.value, "destination_fqdns",null)
      protocols             = rule.value.protocols
    }
  }
}