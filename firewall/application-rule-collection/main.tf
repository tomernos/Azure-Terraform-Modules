locals {
  resource_group_name = element(coalescelist(data.azurerm_resource_group.this.*.name, azurerm_resource_group.this.*.name, [""]), 0)
  location            = element(coalescelist(data.azurerm_resource_group.this.*.location, azurerm_resource_group.this.*.location, [""]), 0)
  public_ip_map       = { for pip in var.public_ip_names : pip => true }

  fw_application_rules = { for idx, rule in var.firewall_application_rules : rule.name => {
    idx : idx,
    rule : rule,
    }
  }
}

resource "azurerm_firewall_application_rule_collection" "fw_app" {
  for_each            = local.fw_application_rules
  name                = lower(format("fw-app-rule-%s-${var.firewall_config.name}-${local.location}", each.key))
  azure_firewall_name = azurerm_firewall.fw.name
  resource_group_name = local.resource_group_name
  priority            = 100 * (each.value.idx + 1)
  action              = each.value.rule.action

  rule {
    name             = each.key
    description      = each.value.rule.description
    source_addresses = each.value.rule.source_addresses
    source_ip_groups = each.value.rule.source_ip_groups
    fqdn_tags        = each.value.rule.fqdn_tags
    target_fqdns     = each.value.rule.target_fqdns

    protocol {
      type = each.value.rule.protocol.type
      port = each.value.rule.protocol.port
    }
  }
}