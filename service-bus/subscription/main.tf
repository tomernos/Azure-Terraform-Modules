resource "azurerm_servicebus_subscription" "this" {
  name                                    = var.name
  topic_id                                = var.topic_id
  max_delivery_count                      = var.max_delivery_count
  auto_delete_on_idle                     = var.auto_delete_on_idle
  default_message_ttl                     = var.default_message_ttl
  lock_duration                           = var.lock_duration
  dead_lettering_on_message_expiration    = var.dead_lettering_on_message_expiration
  dead_lettering_on_filter_evaluation_error = var.dead_lettering_on_filter_evaluation_error
  batched_operations_enabled              = var.enable_batched_operations
  requires_session                        = var.requires_session
  forward_to                              = var.forward_to
  forward_dead_lettered_messages_to       = var.forward_dead_lettered_messages_to
  status                                  = var.status
  client_scoped_subscription_enabled      = var.client_scoped_subscription_enabled
  dynamic "client_scoped_subscription" {
    for_each = var.client_scoped_subscription != null ? toset(["client_scoped_subscription"]) : toset([])
    content {
      client_id                               = lookup(var.client_scoped_subscription, "client_id", null)
      is_client_scoped_subscription_shareable = lookup(var.client_scoped_subscription, "is_client_scoped_subscription_shareable", null)
      is_client_scoped_subscription_durable = lookup(var.client_scoped_subscription, "is_client_scoped_subscription_durable", null)
    }
  }
}

module "subscription-rules" {
  source = "../subscription-rule"
  for_each = var.rules
  name = each.key
  subscription_id = azurerm_servicebus_subscription.this.id
  filter_type = each.value.filter_type
  action = lookup(each.value, "action", null)
  sql_filter = lookup(each.value, "sql_filter", null)
  correlation_filter = lookup(each.value, "correlation_filter", {})
}