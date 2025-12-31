resource "azurerm_storage_account" "this" {
  name                             = var.name
  resource_group_name              = var.resource_group_name
  location                         = var.location
  account_tier                     = var.account_tier
  account_replication_type         = var.account_replication_type
  account_kind                     = var.account_kind
  cross_tenant_replication_enabled = var.cross_tenant_replication_enabled
  access_tier                      = var.access_tier
  edge_zone                        = var.edge_zone
  https_traffic_only_enabled       = var.enable_https_traffic_only
  min_tls_version                  = var.min_tls_version
  allow_nested_items_to_be_public  = var.allow_nested_items_to_be_public
  shared_access_key_enabled        = var.shared_access_key_enabled
  public_network_access_enabled     = var.public_network_access_enabled
  default_to_oauth_authentication   = var.default_to_oauth_authentication
  is_hns_enabled                    = var.is_hns_enabled
  nfsv3_enabled                     = var.nfsv3_enable
  large_file_share_enabled          = var.large_file_share_enabled
  queue_encryption_key_type         = var.queue_encryption_key_type
  table_encryption_key_type         = var.table_encryption_key_typ
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled
  tags                              = var.tags
  dynamic "blob_properties" {
    for_each = can(var.blob_properties) && var.blob_properties != null ? toset(["blob_properties"]) : toset([])
    content {
      versioning_enabled            = lookup(var.blob_properties, "versioning_enabled", false)
      change_feed_enabled           = lookup(var.blob_properties, "change_feed_enabled", false)
      change_feed_retention_in_days = lookup(var.blob_properties, "change_feed_retention_in_days", null)
      default_service_version       = lookup(var.blob_properties, "default_service_version", null)
      last_access_time_enabled      = lookup(var.blob_properties, "last_access_time_enabled", false)
      dynamic "cors_rule" {
        for_each = can(var.blob_properties.cors_rule) ? toset(["cors_rule"]) : toset([])
        content {
          allowed_headers    = var.blob_properties.cors_rule.allowed_headers
          allowed_methods    = var.blob_properties.cors_rule.allowed_methods
          allowed_origins    = var.blob_properties.cors_rule.allowed_origins
          exposed_headers    = var.blob_properties.cors_rule.exposed_headers
          max_age_in_seconds = var.blob_properties.cors_rule.max_age_in_seconds
        }
      }
      dynamic "delete_retention_policy" {
        for_each = can(var.blob_properties.delete_retention_policy) && var.blob_properties.delete_retention_policy != null ? toset(["delete_retention_policy"]) : toset([])
        content {
          days = lookup(var.blob_properties.delete_retention_policy, "days", 7)
        }
      }
      dynamic "container_delete_retention_policy" {
        for_each = can(var.blob_properties.container_delete_retention_policy) ? toset(["container_delete_retention_policy"]) : toset([])
        content {
          days = lookup(var.blob_properties.container_delete_retention_policy, "days", 7)
        }
      }
    }
  }
  dynamic "queue_properties" {
    for_each = can(var.queue_properties) && var.queue_properties != null ? toset(["queue_properties"]) : toset([])
    content {
      dynamic "cors_rule" {
        for_each = can(var.queue_properties.cors_rule) ? toset(["cors_rule"]) : toset([])
        content {
          allowed_headers    = var.queue_properties.cors_rule.allowed_headers
          allowed_methods    = var.queue_properties.cors_rule.allowed_methods
          allowed_origins    = var.queue_properties.cors_rule.allowed_origins
          exposed_headers    = var.queue_properties.cors_rule.exposed_headers
          max_age_in_seconds = var.queue_properties.cors_rule.max_age_in_seconds
        }
      }
      dynamic "logging" {
        for_each = can(var.queue_properties.logging) ? toset(["logging"]) : toset([])
        content {
          delete                = var.queue_properties.logging.delete
          read                  = var.queue_properties.logging.read
          version               = var.queue_properties.logging.version
          write                 = var.queue_properties.logging.write
          retention_policy_days = lookup(var.queue_properties.logging, "retention_policy_days", null)
        }
      }
      dynamic "minute_metrics" {
        for_each = can(var.queue_properties.minute_metrics) ? toset(["minute_metrics"]) : toset([])
        content {
          enabled               = var.queue_properties.minute_metrics.enabled
          version               = var.queue_properties.minute_metrics.version
          include_apis          = lookup(var.queue_properties.minute_metrics, "include_apis", null)
          retention_policy_days = lookup(var.queue_properties.minute_metrics, "retention_policy_days", null)
        }
      }
      dynamic "hour_metrics" {
        for_each = can(var.queue_properties.hour_metrics) ? toset(["hour_metrics"]) : toset([])
        content {
          enabled               = var.queue_properties.hour_metrics.enabled
          version               = var.queue_properties.hour_metrics.version
          include_apis          = lookup(var.queue_properties.hour_metrics, "include_apis", null)
          retention_policy_days = lookup(var.queue_properties.hour_metrics, "retention_policy_days", null)
        }
      }
    }
  }
  dynamic "custom_domain" {
    for_each = can(var.custom_domain) && var.custom_domain != null ? toset(["custom_domain"]) : toset([])
    content {
      name          = var.custom_domain.name
      use_subdomain = var.custom_domain.use_subdomain
    }
  }
  dynamic "customer_managed_key" {
    for_each = can(var.customer_managed_key) && var.custom_domain != null ? toset(["customer_managed_key"]) : toset([])
    content {
      key_vault_key_id          = var.customer_managed_key.key_vault_key_id
      user_assigned_identity_id = var.customer_managed_key.user_assigned_identity_id
    }
  }
  dynamic "static_website" {
    for_each = can(var.static_website) && var.static_website != null ? toset(["static_website "]) : toset([])
    content {
      index_document     = lookup(var.static_website, "index_document", null)
      error_404_document = lookup(var.static_website, "error_404_document", null)
    }
  }
  dynamic "identity" {
    for_each = can(var.identity) && var.identity != null ? toset(["identity"]) : toset([])
    content {
      type         = var.identity.type
      identity_ids = lookup(var.identity, "identity_ids", null)
    }
  }
  dynamic "share_properties" {
    for_each = can(var.share_properties) && var.share_properties != null ? toset(["share_properties"]) : toset([])
    content {
      dynamic "cors_rule" {
        for_each = can(var.share_properties.cors_rule) != null ? toset(["cors_rule"]) : toset([])
        content {
          allowed_headers    = var.share_properties.cors_rule.allowed_headers
          allowed_methods    = var.share_properties.cors_rule.allowed_methods
          allowed_origins    = var.share_properties.cors_rule.allowed_origins
          exposed_headers    = var.share_properties.cors_rule.exposed_headers
          max_age_in_seconds = var.share_properties.cors_rule.max_age_in_seconds
        }
      }
      dynamic "retention_policy" {
        for_each = can(var.share_properties.retention_policy) ? toset(["retention_policy"]) : toset([])
        content {
          days = lookup(var.share_properties.retention_policy, "days", 7)
        }
      }
      dynamic "smb" {
        for_each = can(var.share_properties.smb) ? toset(["smb"]) : toset([])
        content {
          versions                        = lookup(var.share_properties.smb, "versions", null)
          authentication_types            = lookup(var.share_properties.smb, "authentication_types", null)
          kerberos_ticket_encryption_type = lookup(var.share_properties.smb, "kerberos_ticket_encryption_type", null)
          channel_encryption_type         = lookup(var.share_properties.smb, "channel_encryption_type", null)
        }
      }
    }
  }
  dynamic "network_rules" {
    for_each = can(var.network_rules) && var.network_rules != null ? toset(["network_rules "]) : toset([])
    content {
      default_action             = var.network_rules.default_action
      bypass                     = lookup(var.network_rules, "bypass", null)
      ip_rules                   = lookup(var.network_rules, "ip_rules", null)
      virtual_network_subnet_ids = lookup(var.network_rules, "virtual_network_subnet_ids", null)
      dynamic "private_link_access" {
        for_each = can(var.network_rules.private_link_access) ? toset(["private_link_access"]) : toset([])
        content {
          endpoint_resource_id = lookup(var.network_rules.private_link_access, "endpoint_resource_id", null)
          endpoint_tenant_id   = lookup(var.network_rules.private_link_access, "endpoint_tenant_id", null)
        }
      }
    }
  }
  dynamic "azure_files_authentication" {
    for_each = can(var.azure_files_authentication) && var.azure_files_authentication != null ? toset(["azure_files_authentication"]) : toset([])
    content {
      directory_type = var.azure_files_authentication.directory_type
      dynamic "active_directory" {
        for_each = can(var.azure_files_authentication.active_directory) ? toset(["active_directory"]) : toset([])
        content {
          storage_sid         = var.azure_files_authentication.active_directory.storage_sid
          domain_name         = var.azure_files_authentication.active_directory.domain_name
          domain_sid          = var.azure_files_authentication.active_directory.domain_sid
          domain_guid         = var.azure_files_authentication.active_directory.domain_guid
          forest_name         = var.azure_files_authentication.active_directory.forest_name
          netbios_domain_name = var.azure_files_authentication.active_directory.netbios_domain_name
        }
      }
    }
  }
}

module "private-endpoints" {
  source = "../private-endpoint"
  for_each = var.private_endpoints
  name = each.key
  resource_group_name = var.resource_group_name
  location = var.location
  subnet_id = var.subnet_id
  private_dns_zone_group = {
    name = "default"
    private_dns_zone_ids = [for dns_zone in each.value.dns_zone_names : var.private_dns_zones[dns_zone].id]
  }
  private_service_connection = merge(each.value.private_service_connection,
  {
    private_connection_resource_id = azurerm_storage_account.this.id
    subresource_names = each.value.subresource_names
  })
}

module "lifecycle" {
  source = "./lifecycle"
  for_each = var.storage_lifecycle == false ? toset([]) : toset(["lifecycle"])
  rules = try(var.storage_lifecycle.rules, local.lifecycle.rules)
  storage_account_id = azurerm_storage_account.this.id
}