resource "azurerm_private_dns_zone" "this" {
  name                    = var.name
  resource_group_name     = var.resource_group_name
  tags                    = var.tags
}
resource "azurerm_private_dns_zone_virtual_network_link" "this" { 
  name                  = var.environment
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = var.name
  virtual_network_id    = var.virtual_network_id
}

resource "azurerm_private_dns_zone_virtual_network_link" "envs" { 
  for_each              = toset(var.linked_envs)
  name                  = each.value
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = var.name
  virtual_network_id    = "/subscriptions/${var.subscriptions["az-${each.value}"]}/resourceGroups/rg-vnet-westus3-${each.value}/providers/Microsoft.Network/virtualNetworks/vnet-westus3-${each.value}"
}

