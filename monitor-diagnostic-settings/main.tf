
resource "azurerm_monitor_diagnostic_setting" "this" {
  name               = var.name
  target_resource_id = var.target_resource_id
  eventhub_name      = var.eventhub_name

  # one of the four below is mandatory
  eventhub_authorization_rule_id = var.eventhub_authorization_rule_id
  log_analytics_workspace_id = var.log_analytics_workspace_id
  partner_solution_id = var.partner_solution_id
  storage_account_id = var.storage_account_id

  dynamic "enabled_log" {
    for_each = var.enabled_log

    content {
      category       = lookup(enabled_log.value, "category", null)
      category_group = lookup(enabled_log.value, "category_group", null)

      dynamic "retention_policy" {
        for_each = lookup(enabled_log.value, "retention_policy", null) != null ? toset(["retention_policy"]) : toset([])

        content {
          enabled = enabled_log.value.retention_policy.enabled
          days = lookup(enabled_log.value.retention_policy, "days", 0)
        }
      }
    }
  }

  dynamic "metric" {
    for_each = var.metric

    content {
      category = metric.value.category
      enabled  = lookup(metric.value, "enabled", true)
      dynamic "retention_policy" {
        for_each = lookup(metric.value, "retention_policy", null) != null ? toset(["retention_policy"]) : toset([])

        content {
          enabled = metric.value.retention_policy.enabled
          days = lookup(metric.value.retention_policy, "days", 0)
        }
      }
    }
  }
}

