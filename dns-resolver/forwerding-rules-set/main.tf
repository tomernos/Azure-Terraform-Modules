
resource "azurerm_private_dns_resolver_dns_forwarding_ruleset" "this" {
  location                = var.location
  name                    = var.name
  resource_group_name = var.resource_group_name
  private_dns_resolver_outbound_endpoint_ids = var.private_dns_resolver_outbound_endpoint_ids
  tags                    = var.tags
}

module "forwarding-rules" {
  source = "./forwerding-rule"
  for_each = var.forwarding_rules
  name = each.key
  domain_name = each.value.domain_name
  dns_forwarding_ruleset_id = azurerm_private_dns_resolver_dns_forwarding_ruleset.this.id
  target_dns_servers = lookup(each.value, "target_dns_servers", {})
}
module "vnet-links" {
  source = "./vnet-link"
  for_each = var.vnet_links
  name = each.key
  dns_forwarding_ruleset_id = azurerm_private_dns_resolver_dns_forwarding_ruleset.this.id
  virtual_network_id = var.vnets[each.value.vnet_name].id
}

