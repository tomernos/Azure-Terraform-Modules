resource "azurerm_cdn_frontdoor_firewall_policy" "this" {
  for_each = var.create ? toset(["this"]) : toset([])
  name                = var.name
  enabled          = var.enabled 
  resource_group_name = var.resource_group_name
  sku_name = var.sku_name
  mode = var.mode
  request_body_check_enabled = var.request_body_check_enabled
  redirect_url = var.redirect_url
  custom_block_response_status_code = var.custom_block_response_status_code
  custom_block_response_body = var.custom_block_response_body
  tags = var.tags
  dynamic "custom_rule" {
    for_each = var.custom_rule
    content {
      name = custom_rule.key
      action = custom_rule.value.action
      enabled = lookup(custom_rule.value, "enabled", true)
      priority = lookup(custom_rule.value, "priority", true)
      type = lookup(custom_rule.value, "type", null)
      rate_limit_duration_in_minutes = lookup(custom_rule.value, "rate_limit_duration_in_minutes", null)
      rate_limit_threshold = lookup(custom_rule.value, "rate_limit_threshold", null)
      dynamic "match_condition" {
        for_each = lookup(custom_rule.value, "match_condition",{})
        content {
          match_variable = match_condition.value.match_condition
          match_values = match_condition.value.match_condition
          operator = match_condition.value.operator
          selector = lookup(match_condition.value,"selector", null)
          negation_condition = lookup(match_condition.value,"negation_condition", null)
          transforms = lookup(match_condition.value,"transforms", null)
        }
      }

    }
  }
  dynamic "managed_rule" {
    for_each = var.managed_rule
    content {
      type = managed_rule.value.type
      version = managed_rule.value.version
      action = managed_rule.value.action
      dynamic "exclusion" {
        for_each = lookup(managed_rule.value,"exclusion", {})
        content {
          match_variable = exclusion.value.match_variable
          operator = exclusion.value.operator
          selector  = exclusion.value.selector
        }
      }
      dynamic "override" {
        for_each = lookup(managed_rule.value, "override", {})
        content {
          rule_group_name = override.value.rule_group_name
          dynamic "exclusion" {
            for_each = lookup(override.value, "exclusion", {})
            content {
              match_variable = exclusion.value.match_variable
              operator = exclusion.value.operator
              selector  = exclusion.value.selector
            }
          }
          dynamic "rule" {
            for_each = lookup(override.value, "rule", {})
            content {
              rule_id = rule.value.rule_id
              action = rule.value.action
              enabled = lookup(rule.value, "enabled", null)
              dynamic "exclusion" {
                for_each = lookup(rule.value, "exclusion", {})
                content {
                  match_variable = exclusion.value.match_variable
                  operator = exclusion.value.operator
                  selector  = exclusion.value.selector
                }
              }
            }
          }
        }
      }
    }
  }
}

data "azurerm_cdn_frontdoor_firewall_policy" "this" {
  for_each = var.create ? toset([]) : toset(["this"]) 
  name                = var.name
  resource_group_name = var.resource_group_name
}
