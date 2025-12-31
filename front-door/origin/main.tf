resource "azurerm_cdn_frontdoor_origin" "this" {
  name                = var.name
  cdn_frontdoor_origin_group_id         = var.cdn_frontdoor_origin_group_id
  enabled          = var.enabled 
  certificate_name_check_enabled          = var.certificate_name_check_enabled  
  http_port         = var.http_port
  https_port         = var.https_port
  host_name          = var.host_name 
  origin_host_header          = var.origin_host_header 
  priority          = var.priority 
  weight          = var.weight 
  dynamic "private_link" {
    for_each = var.private_link != null ? toset(["private_link"]) : toset([])
    content {
      location = var.private_link.location
      private_link_target_id = var.private_link.private_link_target_id
      request_message = lookup(var.private_link, "request_message", "request fron front door(via Terraform)")
      target_type = lookup(var.private_link, "target_type", null)
    }
  }
}