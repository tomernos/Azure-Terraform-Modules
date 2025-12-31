resource "azurerm_api_management_named_value" "this" {
  name = var.name
  resource_group_name = var.resource_group_name
  api_management_name = var.api_management_name
  display_name = var.display_name
  value = var.value

  dynamic "value_from_key_vault" {
    for_each = var.value_from_key_vault
    content {
      secret_id = value_from_key_vault.value.secret_id
      identity_client_id = value_from_key_vault.value.identity_client_id
    }
  }

  secret = var.secret
}