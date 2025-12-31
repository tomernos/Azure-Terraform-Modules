resource "azurerm_virtual_network" "this" {
  name                = var.name
  location            = var.location
  tags                = var.tags
  resource_group_name = var.resource_group_name
  dns_servers         = var.dns_servers
  address_space       = var.address_space

  dynamic "ddos_protection_plan" {
    for_each = var.ddos_protection_plan
    content {
      id = ddos_protection_plan.value.id
      enable = ddos_protection_plan.value.enable
    }
  }
}