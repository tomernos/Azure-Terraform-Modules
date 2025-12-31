resource "azurerm_cdn_frontdoor_origin_group" "this" {
  for_each = var.create ? toset(["this"]) : toset([])
  name                = var.name
  cdn_frontdoor_profile_id         = var.cdn_frontdoor_profile_id
  session_affinity_enabled          = var.session_affinity_enabled 
  restore_traffic_time_to_healed_or_new_endpoint_in_minutes         = var.restore_traffic_time_to_healed_or_new_endpoint_in_minutes 
  load_balancing {
    additional_latency_in_milliseconds = lookup(var.load_balancing, "additional_latency_in_milliseconds", null)
    sample_size =   lookup(var.load_balancing, "sample_size", null)
    successful_samples_required = lookup(var.load_balancing, "successful_samples_required", null)
  }
  dynamic "health_probe" {
    for_each = var.health_probe != null ? toset(["health_probe"]) : toset([])
    content {
      protocol = var.health_probe.protocol
      interval_in_seconds =  var.health_probe.interval_in_seconds 
      request_type = lookup(var.health_probe, "request_type", null)
      path = lookup(var.health_probe, "path", null)
    }
  }
}

module "origns" {
  source = "../origin"
  for_each = var.origins
  name = each.key
  cdn_frontdoor_origin_group_id      = azurerm_cdn_frontdoor_origin_group.this["this"].id
  enabled = lookup(each.value, "enabled", true)
  host_name = each.value.host_name
  certificate_name_check_enabled = lookup(each.value, "certificate_name_check_enabled",true)
  http_port = lookup(each.value, "http_port", null)
  https_port = lookup(each.value, "https_port", null)
  priority = lookup(each.value, "priority", null)
  weight = lookup(each.value, "weight", null)
  origin_host_header = lookup(each.value, "origin_host_header", null)
  private_link = lookup(each.value, "private_link", null)

}

data "azurerm_cdn_frontdoor_origin_group" "this" {
  for_each = var.create ? toset([]) : toset(["this"])
  name                = var.name
  profile_name        = split("/", var.cdn_frontdoor_profile_id)[8]
  resource_group_name = split("/", var.cdn_frontdoor_profile_id)[4]
}