resource "azurerm_servicebus_topic" "this" {
  name                                    = var.name
  namespace_id                            = var.namespace_id
  status                                  = var.status
  auto_delete_on_idle                     = var.auto_delete_on_idle
  default_message_ttl                     = var.default_message_ttl
  duplicate_detection_history_time_window = var.duplicate_detection_history_time_window
  batched_operations_enabled               = var.enable_batched_operations
  express_enabled                          = var.enable_express
  partitioning_enabled                    = var.enable_partitioning
  max_message_size_in_kilobytes           = var.max_message_size_in_kilobytes
  max_size_in_megabytes                   = var.max_size_in_megabytes
  requires_duplicate_detection            = var.requires_duplicate_detection
  support_ordering                        = var.support_ordering
}