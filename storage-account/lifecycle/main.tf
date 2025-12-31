resource "azurerm_storage_management_policy" "this" {
  storage_account_id = var.storage_account_id
  dynamic "rule" {
    for_each = var.rules
    content {
      name = rule.key
      enabled = rule.value.enabled
      dynamic "actions" {
        for_each = can(rule.value.actions) ? toset(["actions"]) : toset([])
        content {
          dynamic "base_blob" {
            for_each = can(rule.value.actions.base_blob) ? toset(["base_blob"]) : toset([])
            content {
              tier_to_cool_after_days_since_modification_greater_than = lookup(rule.value.actions.base_blob, "tier_to_cool_after_days_since_modification_greater_than",null)
              tier_to_cool_after_days_since_last_access_time_greater_than = lookup(rule.value.actions.base_blob, "tier_to_cool_after_days_since_last_access_time_greater_than",null)
              tier_to_cool_after_days_since_creation_greater_than =  lookup(rule.value.actions.base_blob, "tier_to_cool_after_days_since_creation_greater_than",null)
              tier_to_cold_after_days_since_modification_greater_than = lookup(rule.value.actions.base_blob, "tier_to_cold_after_days_since_modification_greater_than",null)
              tier_to_cold_after_days_since_last_access_time_greater_than = lookup(rule.value.actions.base_blob, "tier_to_cold_after_days_since_last_access_time_greater_than",null)
              tier_to_cold_after_days_since_creation_greater_than = lookup(rule.value.actions.base_blob, "tier_to_cold_after_days_since_creation_greater_than",null)
              auto_tier_to_hot_from_cool_enabled =  lookup(rule.value.actions.base_blob, "auto_tier_to_hot_from_cool_enabled",false)
              tier_to_archive_after_days_since_modification_greater_than =  lookup(rule.value.actions.base_blob, "tier_to_archive_after_days_since_modification_greater_than",null)
              tier_to_archive_after_days_since_last_access_time_greater_than =  lookup(rule.value.actions.base_blob, "tier_to_archive_after_days_since_last_access_time_greater_than",null)
              tier_to_archive_after_days_since_creation_greater_than =  lookup(rule.value.actions.base_blob, "tier_to_archive_after_days_since_creation_greater_than",null)
              tier_to_archive_after_days_since_last_tier_change_greater_than =  lookup(rule.value.actions.base_blob, "tier_to_archive_after_days_since_last_tier_change_greater_than",null)
              delete_after_days_since_modification_greater_than =  lookup(rule.value.actions.base_blob, "delete_after_days_since_modification_greater_than",null)
              delete_after_days_since_last_access_time_greater_than  =  lookup(rule.value.actions.base_blob, "delete_after_days_since_last_access_time_greater_than",null)
              delete_after_days_since_creation_greater_than =  lookup(rule.value.actions.base_blob, "delete_after_days_since_creation_greater_than",null)

            }
          }
        }
      }
      dynamic "filters" {
        for_each = can(rule.value.filters) ? toset(["filters"]) : toset([])
        content {
          blob_types = rule.value.filters.blob_types
          prefix_match = lookup(rule.value.filters, "prefix_match", null)
        }

        
      }
    }
    
  }
}


