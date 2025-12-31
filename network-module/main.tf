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
  for_each = length(var.peerings) > 0 ? var.peerings : {}

  name                      = each.key
  resource_group_name       = each.value.resource_group
  virtual_network_name      = each.value.source_vnet
  remote_virtual_network_id = azurerm_virtual_network.this[each.value.remote_vnet_key].id

  allow_virtual_network_access = lookup(each.value, "allow_virtual_network_access", true)
  allow_forwarded_traffic      = lookup(each.value, "allow_forwarded", true)
  allow_gateway_transit        = lookup(each.value, "allow_gateway_transit", false)
  
  depends_on = [azurerm_virtual_network.this]
}

# Create RouteTables 
resource "azurerm_route_table" "this" {
  for_each = var.route_tables

  name                = each.key
  location            = each.value.location
  resource_group_name = each.value.resource_group
  tags                = merge(var.common_tags, each.value.tags)
}

# Create Routes
resource "azurerm_route" "routes" {
  for_each = var.routes

  name                   = each.key
  resource_group_name    = each.value.resource_group
  route_table_name       = azurerm_route_table.this[each.value.route_table_key].name
  address_prefix         = each.value.address_prefix
  next_hop_type          = each.value.next_hop_type
  next_hop_in_ip_address = lookup(each.value, "next_hop_in_ip_address", null)
}

# Create Public IP
resource "azurerm_public_ip" "vm_pip" {
  name                = "vm-pip"
  location            = var.location
  resource_group_name = var.resource_group
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}
