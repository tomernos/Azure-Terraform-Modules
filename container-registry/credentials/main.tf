resource "azurerm_container_registry_credential_set" "this" {
  name                  = var.name
  container_registry_id = var.container_registry_id
  login_server          = var.login_server
  identity {
    type = "SystemAssigned"
  }
  authentication_credentials {
    username_secret_id = var.authentication_credentials.username_secret_id
    password_secret_id = var.authentication_credentials.password_secret_id
  }
}