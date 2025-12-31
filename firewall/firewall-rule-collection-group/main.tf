data "azurerm_public_ip" "fw-pip" {
  name = split("/",var.public_ip_address_id)[8]
  resource_group_name = split("/",var.public_ip_address_id)[4]
}

resource "azurerm_firewall_policy_rule_collection_group" "this" {
  firewall_policy_id = var.firewall_policy_id
  name               = var.name
  priority           = var.priority

  dynamic "application_rule_collection" {
    for_each = var.application_rule_collection
    content {
      name     = application_rule_collection.key
      action   = application_rule_collection.value.action
      priority = lookup(application_rule_collection.value, "priority", var.priority)

      dynamic "rule" {
        for_each = application_rule_collection.value.rules
        content {
          name        = rule.key
          description = lookup(rule.value, "description",null)
          source_addresses = lookup(rule.value, "source_addresses",null)
          source_ip_groups = lookup(rule.value, "source_ip_groups",null)
          destination_addresses = lookup(rule.value, "destination_addresses",null)
          destination_urls = lookup(rule.value, "destination_urls",null)
          web_categories = lookup(rule.value, "web_categories",null)
          destination_fqdns = lookup(rule.value, "destination_fqdns",null)

          dynamic "protocols" {
            for_each = rule.value.protocols
            content {
              type = lookup(protocols.value, "type",null)
              port = lookup(protocols.value, "port",null)
            }
          }
        }
      }
    }
  }

  dynamic "nat_rule_collection" {
    for_each = var.nat_rule_collection
    content {
      name     = nat_rule_collection.key
      action   = nat_rule_collection.value.action
      priority = lookup(nat_rule_collection.value, "priority", var.priority)

      dynamic "rule" {
        for_each = nat_rule_collection.value.rules

        content {
          name = rule.key
          protocols = rule.value.protocols
          translated_port = lookup(rule.value,"translated_port",null)
          source_addresses = lookup(rule.value,"source_addresses",null)
          source_ip_groups = lookup(rule.value,"source_ip_groups",null)
          destination_address = lookup(rule.value,"destination_addresses",data.azurerm_public_ip.fw-pip.ip_address)
          destination_ports = lookup(rule.value,"destination_ports",null)
          translated_address = lookup(rule.value,"translated_address",null)
          translated_fqdn = lookup(rule.value,"translated_fqdn",null)
        }
      }
    }
  }

  dynamic "network_rule_collection" {
    for_each = var.network_rule_collection
    #!= null ? toset(["network_rule_collection"]) : toset([])
    content {
      name     = network_rule_collection.key
      action   = network_rule_collection.value.action
      priority = lookup(network_rule_collection.value, "priority", var.priority)

      dynamic rule {
        for_each = network_rule_collection.value.rules

        content {
          name              = rule.key
          protocols         = lookup(rule.value,"protocols",null)
          source_addresses = lookup(rule.value,"source_addresses",null)
          source_ip_groups = lookup(rule.value,"source_ip_groups",null)
          destination_ports = lookup(rule.value,"destination_ports",null)
          destination_addresses = lookup(rule.value,"destination_addresses",null)
          destination_ip_groups = lookup(rule.value,"destination_ip_groups",null)
          destination_fqdns = lookup(rule.value,"destination_fqdns",null)
        }
      }
    }
  }
}