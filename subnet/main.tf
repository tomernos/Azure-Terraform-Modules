locals {
  route_table_id = join("/", [ var.subscription_id, "resourceGroups", var.resource_group_name, "providers/Microsoft.Network/routeTables", var.route_table == null ? "" : var.route_table])

}
resource "azurerm_subnet" "this" {
  name                 = var.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.address_prefixes
  service_endpoints    = var.service_endpoints
  private_endpoint_network_policies = var.private_endpoint_network_policies
  dynamic "delegation" {
    for_each = var.delegation
    content {
      name = delegation.key
      service_delegation {
        name    = delegation.value.service_delegation.name
        actions = lookup(delegation.value.service_delegation, "actions", null)
      }
    }
  }
}

module "nsg_association" {
  source                    = "./association-nsg"
  for_each                  = var.nsg != false ? toset(["nsg_association"]) : toset([])
  subnet_id                 = azurerm_subnet.this.id 
  network_security_group_id = var.network_security_group_id
}

module "route_table_association" {
  source         = "./association-table"
  for_each       = var.route_table != "" ? toset(["route_table_association"]) : toset([])
  subnet_id      = azurerm_subnet.this.id 
  route_table_id = local.route_table_id
}

module "private_endpoint" {
  source = "../private-endpoint"
  for_each = var.private_endpoints
  name = each.key
  resource_group_name = var.resource_group_name
  location = each.value.location
  subnet_id = azurerm_subnet.this.id
  
}