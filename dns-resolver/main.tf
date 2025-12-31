resource "azurerm_private_dns_resolver" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  virtual_network_id  = var.virtual_network_id
  tags                = var.tags
}

module "inbound_endpoint" {
  source = "./inbound-endpoint"
  for_each = var.inbound_endpoints
  name = each.key
  subnet_id = var.subnets[each.value.subnet_name].id
  private_dns_resolver_id = azurerm_private_dns_resolver.this.id
  ip_configurations = each.value.ip_configurations
  location = var.location
  tags = merge(var.tags,lookup(each.value, "tags",{}))
}
module "outbound_endpoint" {
  source = "./outbound-endpoint"
  for_each = var.outbound_endpoints
  name = each.key
  subnet_id = var.subnets[each.value.subnet_name].id
  resource_group_name = var.resource_group_name
  private_dns_resolver_id = azurerm_private_dns_resolver.this.id
  location = var.location
  vnets = var.vnets
  forwarding_ruleset = lookup(each.value, "forwarding_ruleset", {})
  tags = merge(var.tags,lookup(each.value, "tags",{}))
}