resource "azurerm_servicebus_subscription_rule" "this" {
  name            = var.name
  subscription_id = var.subscription_id
  filter_type     = var.filter_type
  action = var.action
  sql_filter = var.sql_filter
  dynamic "correlation_filter" {
    for_each = var.correlation_filter
    content {
      content_type = lookup(correlation_filter.value, "content_type", null)
      correlation_id   = lookup(correlation_filter.value, "correlation_id", null)
      label  = lookup(correlation_filter.value, "label", null)
      message_id = lookup(correlation_filter.value, "message_id", null)
      reply_to = lookup(correlation_filter.value, "reply_to", null)
      reply_to_session_id = lookup(correlation_filter.value, "reply_to_session_id", null)
      session_id = lookup(correlation_filter.value, "session_id", null)
      to = lookup(correlation_filter.value, "to", null)
    }
  }

}