
resource "azurerm_private_dns_resolver_forwarding_rule" "this" {
  name                    = var.name
  domain_name                = var.domain_name
  dns_forwarding_ruleset_id = var.dns_forwarding_ruleset_id
  dynamic "target_dns_servers" {
    for_each = var.target_dns_servers
    content {
      ip_address = lookup(target_dns_servers.value, "ip_address", null)
      port =  lookup(target_dns_servers.value, "port", null)
    }
  }
  metadata = var.metadata
}

