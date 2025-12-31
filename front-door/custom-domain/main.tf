resource "azurerm_cdn_frontdoor_custom_domain" "this" {
  for_each = var.create ? toset(["this"]) : toset([])
  name = var.name
  cdn_frontdoor_profile_id         = var.cdn_frontdoor_profile_id
  dns_zone_id         = var.dns_zone_id
  host_name = var.host_name
  tls {
    certificate_type = lookup(var.tls, "certificate_type",null)
    minimum_tls_version = lookup(var.tls, "minimum_tls_version","TLS12")
    cdn_frontdoor_secret_id = lookup(var.tls, "cdn_frontdoor_secret_id",null)
  }
}

data "azurerm_cdn_frontdoor_custom_domain" "this" {
  for_each = var.create ? toset([]) : toset(["this"]) 
  name                = var.name
  profile_name        = split("/", var.cdn_frontdoor_profile_id)[8]
  resource_group_name = split("/", var.cdn_frontdoor_profile_id)[4]
}