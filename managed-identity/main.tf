resource "azurerm_user_assigned_identity" "managed_identity" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_role_assignment" "managed_identity_roles" {
  for_each = toset(var.role_definitions)

  principal_id         = azurerm_user_assigned_identity.managed_identity.principal_id
  scope                = var.scope != null ? var.scope : data.azurerm_resource_group.this.id
  role_definition_name = each.key
}

resource "azurerm_role_assignment" "additional_managed_identity_roles" {
  for_each = { for idx, role in var.additional_role_assignments : idx => role }

  principal_id         = azurerm_user_assigned_identity.managed_identity.principal_id
  scope                = var.scope != null ? var.scope : each.value.resource_id
  role_definition_name = each.value.role_name
}

resource "azurerm_federated_identity_credential" "managed_identity" {
  name                = "${upper(var.name)}_FID"
  resource_group_name = var.resource_group_name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = var.aks_oidc_issuer_url
  parent_id           = azurerm_user_assigned_identity.managed_identity.id
  subject             = "system:serviceaccount:${var.serviceaccount_namespace}:${var.serviceaccount_name}"
}

# Add data source for resource group
data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}
