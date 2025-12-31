resource "azurerm_cdn_frontdoor_security_policy" "this" {
  name                = var.name
  cdn_frontdoor_profile_id          = var.cdn_frontdoor_profile_id 
  security_policies {
    firewall {
      cdn_frontdoor_firewall_policy_id = var.cdn_frontdoor_firewall_policy_id
      association {
        patterns_to_match = var.patterns_to_match
        dynamic "domain" {
          for_each = var.domain_ids
          content {
            cdn_frontdoor_domain_id = domain.value
          }
        }
      }
    }
  }
}