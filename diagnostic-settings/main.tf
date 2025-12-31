resource "azurerm_monitor_diagnostic_setting" "this" {
  name                = var.name
  target_resource_id = var.target_resource_id
  eventhub_name = var.eventhub_name
  eventhub_authorization_rule_id = var.eventhub_authorization_rule_id
  log_analytics_workspace_id = var.log_analytics_workspace_id
  storage_account_id = var.storage_account_id
  log_analytics_destination_type = var.log_analytics_destination_type
  partner_solution_id = var.partner_solution_id
  dynamic "enabled_log" {
    for_each = var.enabled_log
    content {
      category = lookup(enabled_log.value,"category",null)
      category_group = lookup(enabled_log.value,"category_group")
    }
  }
  dynamic "metric" {
    for_each = var.metric
    content {
      category = metric.value.category
      enabled = lookup(metric.value,"enabled", null)
    }
  }
}

