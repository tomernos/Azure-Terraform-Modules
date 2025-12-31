resource "azurerm_monitor_aad_diagnostic_setting" "this" {
  name                = var.name
  eventhub_name = var.eventhub_name
  eventhub_authorization_rule_id = var.eventhub_authorization_rule_id
  log_analytics_workspace_id = var.log_analytics_workspace_id
  storage_account_id = var.storage_account_id
  dynamic "enabled_log" {
    for_each = var.enabled_log
    content {
      category = lookup(enabled_log.value,"category",null)
    }
  }
}

