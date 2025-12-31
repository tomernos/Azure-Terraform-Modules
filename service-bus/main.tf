resource "azurerm_servicebus_namespace" "this" {
  name                         = var.namespace_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  sku                          = var.sku
  tags                         = var.tags
  capacity                     = var.capacity
  premium_messaging_partitions = var.premium_messaging_partitions
  local_auth_enabled           = var.local_auth_enabled
  public_network_access_enabled = var.public_network_access_enabled
  minimum_tls_version           = var.minimum_tls_version
  dynamic "identity" {
    for_each = var.identity != {} ? toset(["identity"]) : toset([])
    content {
      type         = var.identity.type
      identity_ids = lookup(var.identity, "identity_ids", null)
    }
  }
  dynamic "customer_managed_key" {
    for_each = var.customer_managed_key != {} ? toset(["customer_managed_key"]) : toset([])
    content {
      key_vault_key_id = var.customer_managed_key.key_vault_key_id
      identity_id      = var.customer_managed_key.identity_id
      infrastructure_encryption_enabled = lookup(var.customer_managed_key, "infrastructure_encryption_enabled", null)
    }
  }
  dynamic "network_rule_set" {
    for_each = var.network_rule_set != {} ? toset(["network_rule_set"]) : toset([])
    content {
      default_action = lookup(var.network_rule_set, "default_action", "Allow")
      public_network_access_enabled = lookup(var.network_rule_set, "public_network_access_enabled", false)
      trusted_services_allowed = lookup(var.network_rule_set, "trusted_services_allowed", null)
      ip_rules                 = lookup(var.network_rule_set, "ip_rules", null)
      dynamic "network_rules" {
        for_each = can(var.network_rule_set.network_rules) ? var.network_rule_set.network_rules : toset([])
        content {
          subnet_id = network_rules.value.subnet_id
          ignore_missing_vnet_service_endpoint = lookup(network_rules.value,"ignore_missing_vnet_service_endpoint", null)
        }
      }

    }
  }
  lifecycle {
    ignore_changes = [network_rule_set]
  }
}

module "queues" {
  source = "./queue"
  for_each = var.queues
  name                                     = each.key
  namespace_id                             = azurerm_servicebus_namespace.this.id
  lock_duration                            = lookup(each.value,"lock_duration" ,null)
  max_message_size_in_kilobytes            = lookup(each.value,"max_message_size_in_kilobytes" ,null)
  max_size_in_megabytes                    = lookup(each.value,"max_size_in_megabytes" ,null)
  requires_duplicate_detection             = lookup(each.value,"requires_duplicate_detection" ,null)
  requires_session                         = lookup(each.value,"requires_session" ,null)
  default_message_ttl                      = lookup(each.value,"default_message_ttl" ,null)
  dead_lettering_on_message_expiration     = lookup(each.value,"dead_lettering_on_message_expiration" ,null)
  duplicate_detection_history_time_window  = lookup(each.value,"duplicate_detection_history_time_window" ,null)
  max_delivery_count                       = lookup(each.value,"max_delivery_count" ,null)
  status                                   = lookup(each.value,"status" ,null)
  enable_batched_operations                = lookup(each.value,"enable_batched_operations" ,null)
  auto_delete_on_idle                      = lookup(each.value,"auto_delete_on_idle" ,null)
  enable_partitioning                      = lookup(each.value,"enable_partitioning" ,null)
  enable_express                           = lookup(each.value,"enable_express" ,null)
  forward_to                               = lookup(each.value,"forward_to" ,null)
  forward_dead_lettered_messages_to        = lookup(each.value,"forward_dead_lettered_messages_to" ,null)
}

module "topics" {
  source = "./topic"
  for_each = var.topics
  name                                    = each.key
  namespace_id                            = azurerm_servicebus_namespace.this.id
  status                                  = lookup(each.value,"status", null)
  auto_delete_on_idle                     = lookup(each.value,"auto_delete_on_idle", null)
  default_message_ttl                     = lookup(each.value,"default_message_ttl", null)
  duplicate_detection_history_time_window = lookup(each.value,"duplicate_detection_history_time_window", null)
  enable_batched_operations               = lookup(each.value,"enable_batched_operations", null)
  enable_express                          = lookup(each.value,"enable_express", null)
  enable_partitioning                     = lookup(each.value,"enable_partitioning", null)
  max_message_size_in_kilobytes           = lookup(each.value,"max_message_size_in_kilobytes", null)
  max_size_in_megabytes                   = lookup(each.value,"max_size_in_megabytes", null)
  requires_duplicate_detection            = lookup(each.value,"requires_duplicate_detection", null)
  support_ordering                        = lookup(each.value,"support_ordering", null)
}

module "subscriptions" {
  source = "./subscription"
  for_each = var.subscriptions
  name                                    = each.key
  topic_id                                = module.topics[each.value.topic_name].id
  max_delivery_count                      = each.value.max_delivery_count
  auto_delete_on_idle                     = lookup(each.value,"auto_delete_on_idle", null)
  default_message_ttl                     = lookup(each.value,"default_message_ttl", null)
  rules                     = lookup(each.value,"rules", {})
  lock_duration                           = lookup(each.value,"lock_duration", null)
  dead_lettering_on_message_expiration    = lookup(each.value,"dead_lettering_on_message_expiration", null)
  dead_lettering_on_filter_evaluation_error = lookup(each.value,"dead_lettering_on_filter_evaluation_error", null)
  enable_batched_operations               = lookup(each.value,"enable_batched_operations", null)
  requires_session                        = lookup(each.value,"requires_session", null)
  forward_to                              = lookup(each.value,"forward_to", null)
  forward_dead_lettered_messages_to       = lookup(each.value,"forward_dead_lettered_messages_to", null)
  status                                  = lookup(each.value,"status", null)
  client_scoped_subscription_enabled      = lookup(each.value,"client_scoped_subscription_enabled", null)
  client_scoped_subscription              = lookup(each.value,"client_scoped_subscription", null)
}

module "private-endpoints" {
  source = "../private-endpoint"
  for_each = var.private_endpoint ? toset(["private-endpoint"]) : toset([])
  name = "${var.namespace_name}-endpoint"
  resource_group_name = var.resource_group_name
  location = var.location
  subnet_id = var.subnet_id
  private_dns_zone_group = {
    name = "default"
    private_dns_zone_ids = [var.private_dns_zones["privatelink.servicebus.windows.net"].id]
  }
  private_service_connection = {
    name = "${var.namespace_name}-endpoint"
    private_connection_resource_id = azurerm_servicebus_namespace.this.id
    subresource_names = ["namespace"]
    is_manual_connection = false
  }
}