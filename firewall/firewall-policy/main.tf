
resource "azurerm_firewall_policy" "this" {
  location            = var.location
  name                = var.name
  resource_group_name = var.resource_group_name
  private_ip_ranges   = var.private_ip_ranges
  tags                = var.tags
}

module "rule-collection" {
  source = "../firewall-rule-collection-group"
  for_each = var.rule_collections
  name = each.key
  firewall_policy_id = azurerm_firewall_policy.this.id
  priority                    = each.value.priority
  network_rule_collection     = lookup(each.value, "network_rule_collection", {})
  nat_rule_collection     = lookup(each.value, "nat_rule_collection", {})
  public_ip_address_id = var.public_ip_address_id
}