resource "azurerm_cdn_frontdoor_rule_set" "this" {
  for_each = var.create ? toset(["this"]) : toset([])
  name                = var.name
  cdn_frontdoor_profile_id          = var.cdn_frontdoor_profile_id 
}
module "rules" {
  source = "../rule"
  for_each = var.rules
  name = each.key
  behavior_on_match = lookup(each.value, "behavior_on_match", null)
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.this["this"].id
  order = each.value.order
  actions = each.value.actions
  conditions = lookup(each.value, "conditions", null)
}

data "azurerm_cdn_frontdoor_rule_set" "this" {
  for_each = var.create ? toset([]) : toset(["this"])
  name                = var.name
  profile_name        = split("/", var.cdn_frontdoor_profile_id)[8]
  resource_group_name = split("/", var.cdn_frontdoor_profile_id)[4]
}