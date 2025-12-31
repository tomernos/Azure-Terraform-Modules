resource "azurerm_container_registry" "acr" {
  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  sku                           = var.sku
  admin_enabled                 = var.admin_enabled
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = var.tags
  retention_policy_in_days      = var.retention_policy_in_days
  zone_redundancy_enabled       = var.zone_redundancy_enabled
  network_rule_bypass_option    = "AzureServices"

  dynamic "georeplications" {
    for_each = var.georeplications
    content {
      location                  = georeplications.value.location
      regional_endpoint_enabled = lookup(georeplications.value, "regional_endpoint_enabled", null)
      zone_redundancy_enabled   = lookup(georeplications.value, "zone_redundancy_enabled", null)
      tags                      = lookup(georeplications.value, "tags", null)
    }
  }

  dynamic "network_rule_set" {
    for_each = var.network_rule_set
    content {
      default_action = lookup(network_rule_set.value, "default_action", "Deny")
      
      dynamic "ip_rule" {
        for_each = lookup(network_rule_set.value, "ip_rule", [])
        content {
          action   = "Allow"
          ip_range = ip_rule.value
        }
      }
    }
  }

  dynamic "identity" {
    for_each = var.identity != null ? toset(["identity"]) : toset([])
    content {
      type         = var.identity.type
      identity_ids = lookup(var.identity, "identity_ids", null)
    }
  }

  dynamic "encryption" {
    for_each = var.encryption != null ? toset(["encryption"]) : toset([])
    content {
      key_vault_key_id   = var.encryption.key_vault_key_id
      identity_client_id = var.encryption.identity_client_id
    }
  }

}

resource "azurerm_container_registry_task" "acr_task" {
  for_each = var.tasks
  name                  = each.key
  container_registry_id = azurerm_container_registry.acr.id
  
  platform {
    os = "Linux"
  }

  timer_trigger {
    name     = each.key
    schedule = lookup(each.value, "schedule", "0 0 * * *")
  }

  base_image_trigger {
    name                = each.key
    type                = "Runtime"
    enabled             = true
  }

  encoded_step {
    task_content = base64encode(<<-EOT
      version: v1.1.0
      steps:
        - cmd: ${lookup(each.value, "cmd", "")}
    EOT
    )
  }
  tags     = var.tags
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
    private_dns_zone_ids = [var.private_dns_zones["privatelink.azurecr.io"].id]
  }
  private_service_connection = merge(each.value.private_service_connection,
  {
    private_connection_resource_id = azurerm_container_registry.acr.id
    subresource_names = ["registry"]
  })
}

module "credentials" {
  source = "./credentials"
  for_each = var.credentials
  name = each.key
  container_registry_id = azurerm_container_registry.acr.id
  login_server = each.value.login_server
  authentication_credentials = each.value.authentication_credentials
}
data "azurerm_key_vault" "key_vault"{
  name = "kv-${var.location}-mgmt"
  resource_group_name = "rg-key-vault-${var.location}-mgmt"
}
module "creds-role-assignemnts" {
  for_each = var.credentials
  source = "../role-assignment"
  principal_id = module.credentials[each.key].identity[0].principal_id
  role_definition_name = "Key Vault Secrets User"
  scope = data.azurerm_key_vault.key_vault.id
}
module "cache-rules" {
  source = "./cache-rule"
  for_each = var.cache_rules
  name = each.key
  container_registry_id = azurerm_container_registry.acr.id
  target_repo = each.value.target_repo
  source_repo = each.value.source_repo
  credential_set_id = module.credentials[each.value.credential_set_name].id
}
module "monitor-diagnostic-settings" {
  source  = "../monitor-diagnostic-settings"
  for_each = var.diagnostic_settings != {} ? toset(["diagnostic-settings"]) : toset([])
  name                       = var.diagnostic_settings.name
  log_analytics_workspace_id = var.log_analytics_workspace_id
  target_resource_id         = azurerm_container_registry.acr.id
  enabled_log                = var.diagnostic_settings.enabled_log
  metric                     = lookup(var.diagnostic_settings, "metric", {})
}
