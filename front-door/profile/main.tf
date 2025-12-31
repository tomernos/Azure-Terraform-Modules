resource "azurerm_cdn_frontdoor_profile" "this" {
  for_each = var.create ? toset(["this"]) : toset([])
  name                = var.name
  tags                = var.tags
  resource_group_name = var.resource_group_name
  sku_name         = var.sku_name
  response_timeout_seconds         = var.response_timeout_seconds
}
module "custom-domain" {
  source = "../custom-domain"
  for_each = var.custom_domain
  create = lookup(each.value, "create", true)
  name = each.key
  tags = var.tags
  cdn_frontdoor_profile_id = var.create ? azurerm_cdn_frontdoor_profile.this["this"].id : data.azurerm_cdn_frontdoor_profile.this["this"].id
  dns_zone_id = lookup(each.value, "dns_zone_id", null)
  host_name = each.value.host_name
  tls = lookup(each.value, "tls",local.tls)
}
module "origin-groups" {
  source = "../origin-group"
  for_each = var.origin_groups
  create = lookup(each.value, "create", true)
  name = each.key
  cdn_frontdoor_profile_id = var.create ? azurerm_cdn_frontdoor_profile.this["this"].id : data.azurerm_cdn_frontdoor_profile.this["this"].id
  session_affinity_enabled = lookup(each.value, "session_affinity_enabled", true)
  health_probe = lookup(each.value, "health_probe", local.default_health_probe)
  load_balancing = lookup(each.value, "load_balancing", local.default_load_balancing)
  origins = lookup(each.value, "origins", {})
  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = lookup(each.value,"restore_traffic_time_to_healed_or_new_endpoint_in_minutes", 0)
}
module "endpoints" {
  source = "../endpoint"
  for_each = var.endpoints
  create = lookup(each.value, "create", true)
  name = each.key
  enabled = lookup(each.value, "enabled", true)
  cdn_frontdoor_profile_id = var.create ? azurerm_cdn_frontdoor_profile.this["this"].id : data.azurerm_cdn_frontdoor_profile.this["this"].id
}
module "rule-sets" {
  source = "../rule-set"
  for_each = var.rule_sets
  create = lookup(each.value, "create", true)
  name = each.key
  cdn_frontdoor_profile_id = var.create ? azurerm_cdn_frontdoor_profile.this["this"].id : data.azurerm_cdn_frontdoor_profile.this["this"].id
  rules = lookup(each.value,"rules", {})
}
module "waf-policy" {
  source = "../waf-policy"
  for_each = var.waf_policies
  name = each.key
  resource_group_name = var.resource_group_name
  sku_name = var.sku_name
  mode = lookup(each.value, "mode", "Prevention")
  managed_rule = lookup(each.value, "managed_rules", {})
  custom_rule = lookup(each.value, "custom_rules", {})
  tags = var.tags
}
module "routes" {
  source = "../route"
  for_each = var.routes
  name   = each.key
  cdn_frontdoor_endpoint_id = try(module.endpoints[each.value.endpoint_name].id, each.value.cdn_frontdoor_endpoint_id)
  cdn_frontdoor_origin_group_id = try(module.origin-groups[each.value.origin_group_name].id, each.value.cdn_frontdoor_origin_group_id)
  cdn_frontdoor_origin_ids = try(each.value.cdn_frontdoor_origin_ids, [for origin in module.origin-groups[each.value.origin_group_name].origins : origin.id])
  cdn_frontdoor_custom_domain_ids = try(each.value.cdn_frontdoor_custom_domain_ids,  [for domain in each.value.domain_names: module.custom-domain[domain].id])
  patterns_to_match = lookup(each.value, "patterns_to_match", local.default_route.patterns_to_match)
  cdn_frontdoor_rule_set_ids = try([for rule_set_name in each.value.rule_set_names: module.rule-sets[rule_set_name].id ], null)
  supported_protocols = lookup(each.value, "supported_protocols", local.default_route.supported_protocols)
  link_to_default_domain = lookup(each.value, "link_to_default_domain", local.default_route.link_to_default_domain)
  cdn_frontdoor_origin_path = lookup(each.value, "cdn_frontdoor_origin_path", null)
  cache = lookup(each.value, "cache", local.default_route.cache)
  https_redirect_enabled = lookup(each.value, "https_redirect_enabled", local.default_route.https_redirect_enabled)
}
module "security-policy" {
  source = "../security-policy"
  for_each = var.security_policies
  name = each.key
  patterns_to_match = each.value.patterns_to_match
  cdn_frontdoor_profile_id = var.create ? azurerm_cdn_frontdoor_profile.this["this"].id : data.azurerm_cdn_frontdoor_profile.this["this"].id
  cdn_frontdoor_firewall_policy_id = module.waf-policy[each.value.waf_policy_key].id
  domain_ids = try([for domain in each.value.custom_domain_keys: module.custom-domain[domain].id], [])
}

# module "diagnostic-settings" {
#   source = "../../diagnostic-settings"
#   for_each = var.diagnostic_settings
#   name = each.key
#   target_resource_id = var.create ? azurerm_cdn_frontdoor_profile.this["this"].id : data.azurerm_cdn_frontdoor_profile.this["this"].id
#   eventhub_name = lookup(each.value,"eventhub_name", null)
#   log_analytics_workspace_id = lookup(each.value,"log_analytics_workspace_id", null)
#   storage_account_id = lookup(each.value,"storage_account_id", null)
#   eventhub_authorization_rule_id = lookup(each.value,"eventhub_authorization_rule_id", null)
#   log_analytics_destination_type = lookup(each.value,"log_analytics_destination_type", null)
#   partner_solution_id = lookup(each.value,"partner_solution_id", null)
#   enabled_log = lookup(each.value,"enabled_log", {})
#   metric = lookup(each.value,"metric", {})
# }




data "azurerm_cdn_frontdoor_profile" "this" {
  for_each = var.create ? toset([]) : toset(["this"]) 
  name                = var.name
  resource_group_name = var.resource_group_name
}