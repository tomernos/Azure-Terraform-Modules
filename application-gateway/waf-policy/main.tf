data "azurerm_web_application_firewall_policy" "this" {
  name                = var.create ? azurerm_web_application_firewall_policy.this["wafPolicy"].name : var.name
  resource_group_name = var.resource_group_name
}

resource "azurerm_web_application_firewall_policy" "this" {
  for_each = var.create ? toset(["wafPolicy"]) : toset([])

  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  dynamic "custom_rules" {
    for_each = var.custom_rules
    content {
      name         = custom_rules.key
      priority     = custom_rules.value.priority
      rule_type    = custom_rules.value.rule_type
      action       = custom_rules.value.action
      dynamic match_conditions {
        for_each = custom_rules.value.match_conditions
        content {
          match_values = lookup(match_conditions.value, "match_values", null)
          operator     = lookup(match_conditions.value, "operator", "IPMatch")
          negation_condition = lookup(match_conditions.value, "negation_condition", null)
          transforms = lookup(match_conditions.value, "transforms", null)
          dynamic match_variables {
            for_each = match_conditions.value.match_variables
            content {
              variable_name = lookup(match_variables.value,"variable_name", "RemoteAddr")
              selector = lookup(match_variables.value,"selector",null)
            }
          }
        }
      }
    }
  }
  # Configure the managed rules for the WAF policy
  dynamic "managed_rules" {
    for_each = var.managed_rules

    content {
      dynamic "managed_rule_set" {
        for_each = managed_rules.value.managed_rule_set
        content {
          type             = managed_rule_set.value.type
          version          = managed_rule_set.value.version
        }
      }
    }
  }

  dynamic "policy_settings" {
    for_each = var.policy_settings
    content {
      enabled = lookup(policy_settings.value, "enabled", true)
      mode = lookup(policy_settings.value, "mode", "Prevention")
      file_upload_limit_in_mb = lookup(policy_settings.value, "file_upload_limit_in_mb", 100)
      request_body_check = lookup(policy_settings.value, "request_body_check", true)
      max_request_body_size_in_kb = lookup(policy_settings.value, "max_request_body_size_in_kb", 128)
    }
  }
}