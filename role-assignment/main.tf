resource "azurerm_role_assignment" "this" {
  name                 = var.name
  role_definition_name = var.role_definition_name
  role_definition_id = var.role_definition_id
  scope                = var.scope
  principal_id         = var.principal_id
}