resource "azurerm_firewall" "this" {
  location            = var.location
  name                = var.name
  resource_group_name = var.resource_group_name
  sku_name            = var.sku_name
  sku_tier            = var.sku_tier
  firewall_policy_id  = var.firewall_policy_id == null ? module.firewall-policy["firewall-policy"].id : var.firewall_policy_id
  dns_servers         = var.dns_servers
  private_ip_ranges   = var.private_ip_ranges
  threat_intel_mode   = var.threat_intel_mode
  zones               = var.zones
  tags                = var.tags

  dynamic "ip_configuration" {
    for_each = var.ip_configuration != null ? toset(["ip_configuration"]) : toset([])
    content {
      name                 = var.ip_configuration.name
      subnet_id            = lookup(var.ip_configuration, "subnet_id", null)
      public_ip_address_id = var.ip_configuration.public_ip_address_id
    }
  }

  dynamic "management_ip_configuration" {
    for_each = var.management_ip_configuration != null ? toset(["management_ip_configuration"]) : toset([])
    content {
      name                 = var.management_ip_configuration.name
      public_ip_address_id = var.management_ip_configuration.public_ip_address_id
      subnet_id            = var.management_ip_configuration.subnet_id
    }
  }

  dynamic "virtual_hub" {
    for_each = var.virtual_hub != null ? toset(["virtual_hub"]) : toset([])
    content {
      virtual_hub_id = var.virtual_hub.virtual_hub_id
      public_ip_count = lookup(var.virtual_hub,"public_ip_count","1")
    }
  }
}

module "firewall-policy" {
  source  = "./firewall-policy"
  for_each = var.firewall_policy != null ? toset(["firewall-policy"]) : toset([])
  location            = var.location
  name                = var.firewall_policy.name
  resource_group_name = lookup(var.firewall_policy, "resource_group_name", var.resource_group_name)
  private_ip_ranges   = lookup(var.firewall_policy, "private_ip_ranges", null)
  rule_collections    = lookup(var.firewall_policy, "rule_collections", {})
  public_ip_address_id = var.ip_configuration.public_ip_address_id
  tags                = merge(var.tags, lookup(var.firewall_policy, "tags", {}))
}


module "monitor-diagnostic-settings" {
  source  = "../monitor-diagnostic-settings"
  for_each = var.diagnostic_settings != {} ? toset(["diagnostic-settings"]) : toset([])
  name                       = var.diagnostic_settings.name
  log_analytics_workspace_id = var.log_analytics_workspace_id
  target_resource_id         = azurerm_firewall.this.id
  enabled_log                = var.diagnostic_settings.enabled_log
  metric                     = var.diagnostic_settings.metric
}
