resource "azurerm_route_table" "this" {
  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  tags                          = var.tags

}
module "routes" {
  source = "./route"
  for_each = var.routes
  name = each.key
  resource_group_name = var.resource_group_name
  location = var.location
  address_prefix = each.value.address_prefix
  route_table_name = var.name
  next_hop_type = each.value.next_hop_type
  next_hop_in_ip_address = lookup(each.value,"next_hop_in_ip_address", null)
}