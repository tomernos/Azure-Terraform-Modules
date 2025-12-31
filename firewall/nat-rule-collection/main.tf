locals {
  resource_group_name = element(coalescelist(data.azurerm_resource_group.this.*.name, azurerm_resource_group.this.*.name, [""]), 0)
  location            = element(coalescelist(data.azurerm_resource_group.this.*.location, azurerm_resource_group.this.*.location, [""]), 0)
  public_ip_map       = { for pip in var.public_ip_names : pip => true }

  fw_nat_rules = { for idx, rule in var.firewall_nat_rules : rule.name => {
    idx : idx,
    rule : rule,
    }
  }
}

resource "azurerm_firewall_nat_rule_collection" "fw" {
  for_each            = local.fw_nat_rules
  name                = lower(format("fw-nat-rule-%s-${var.firewall_config.name}-${local.location}", each.key))
  azure_firewall_name = azurerm_firewall.fw.name
  resource_group_name = local.resource_group_name
  priority            = 100 * (each.value.idx + 1)
  action              = each.value.rule.action

  rule {
    name                  = each.key
    description           = each.value.rule.description
    source_addresses      = each.value.rule.source_addresses
    destination_ports     = each.value.rule.destination_ports
    destination_addresses = [for dest in each.value.rule.destination_addresses : contains(var.public_ip_names, dest) ? azurerm_public_ip.fw-pip[dest].ip_address : dest]
    protocols             = each.value.rule.protocols
    translated_address    = each.value.rule.translated_address
    translated_port       = each.value.rule.translated_port
  }
}