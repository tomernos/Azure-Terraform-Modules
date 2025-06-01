resource "azurerm_resource_group" "this" {
  for_each = var.resource_groups

  name     = each.key
  location = each.value.location
  tags     = merge(var.common_tags, each.value.tags)
}

# Create multiple VNETs
resource "azurerm_virtual_network" "this" {
  for_each            = var.vnets

  name                = each.key
  location            = each.value.location
  resource_group_name = each.value.resource_group
  address_space       = each.value.address_space
  tags = merge(var.common_tags, each.value.tags)

  depends_on = [azurerm_resource_group.this]
}

# Create multiple subnets
resource "azurerm_subnet" "this" {
  for_each = var.subnets

  name                 = each.key
  resource_group_name  = each.value.resource_group
  virtual_network_name = each.value.virtual_network
  address_prefixes     = each.value.cidr

  depends_on = [azurerm_virtual_network.this]
}

# Create VNET peerings
resource "azurerm_virtual_network_peering" "peer" {
  for_each = var.peerings

  name                      = each.key
  resource_group_name       = each.value.resource_group
  virtual_network_name      = each.value.source_vnet
  remote_virtual_network_id = azurerm_virtual_network.this[each.value.remote_vnet_key].id

  allow_virtual_network_access = lookup(each.value, "allow_vnet_access", true)
  allow_forwarded_traffic      = lookup(each.value, "allow_forwarded", true)
  
  depends_on = [azurerm_virtual_network.this]
}