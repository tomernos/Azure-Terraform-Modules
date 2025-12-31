terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.27.0"
    }
  }
}

resource "azurerm_cdn_frontdoor_profile" "frontdoor_profile" {
  name                = var.profile_name
  resource_group_name = var.resource_group_name
  sku_name            = var.sku_name

  tags                = var.tags
}

# Multiple endpoints support
resource "azurerm_cdn_frontdoor_endpoint" "frontdoor_endpoints" {
  for_each = { for endpoint in var.endpoints : endpoint.name => endpoint }

  name                     = each.value.name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.frontdoor_profile.id
  
  tags                     = var.tags
}

# Multiple origin groups support
resource "azurerm_cdn_frontdoor_origin_group" "frontdoor_origin_groups" {
  for_each = { for group in var.origin_groups : group.name => group }

  name                     = each.value.name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.frontdoor_profile.id
  session_affinity_enabled = each.value.session_affinity_enabled

  load_balancing {
    additional_latency_in_milliseconds = each.value.additional_latency_in_milliseconds
    sample_size                        = each.value.sample_size
    successful_samples_required        = each.value.successful_samples_required
  }
}

# Multiple origins support
resource "azurerm_cdn_frontdoor_origin" "frontdoor_origins" {
  for_each = { for origin in var.origins : origin.name => origin }

  name                           = each.value.name
  cdn_frontdoor_origin_group_id  = azurerm_cdn_frontdoor_origin_group.frontdoor_origin_groups[each.value.origin_group_name].id
  certificate_name_check_enabled = each.value.certificate_name_check_enabled
  host_name                      = each.value.host_name
  origin_host_header             = each.value.origin_host_header
  priority                       = each.value.priority
  weight                         = each.value.weight
}