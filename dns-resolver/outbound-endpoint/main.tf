
resource "azurerm_private_dns_resolver_outbound_endpoint" "this" {
  location                = var.location
  name                    = var.name
  private_dns_resolver_id = var.private_dns_resolver_id
  tags                    = var.tags
  subnet_id               = var.subnet_id
}

module "forwarding_ruleset" {
  source = "../forwerding-rules-set"
  for_each = var.forwarding_ruleset
  name = each.key
  resource_group_name = var.resource_group_name
  forwarding_rules = lookup(each.value, "forwarding_rules", {})
  private_dns_resolver_outbound_endpoint_ids = [azurerm_private_dns_resolver_outbound_endpoint.this.id]
  location = var.location
  vnets = var.vnets
  vnet_links = lookup(each.value, "vnet_links", {})
  tags = merge(var.tags,lookup(each.value, "tags",{}))
}