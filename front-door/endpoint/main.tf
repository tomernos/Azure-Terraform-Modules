resource "azurerm_cdn_frontdoor_endpoint" "this" {
  for_each = var.create ? toset(["this"]) : toset([])
  name                = var.name
  cdn_frontdoor_profile_id         = var.cdn_frontdoor_profile_id 
  tags = var.tags
  enabled = var.enabled
}
data "azurerm_cdn_frontdoor_endpoint" "this" {
  for_each = var.create ? toset([]) : toset(["this"])
  name                = var.name
  profile_name        = split("/", var.cdn_frontdoor_profile_id)[8]
  resource_group_name = split("/", var.cdn_frontdoor_profile_id)[4]
}