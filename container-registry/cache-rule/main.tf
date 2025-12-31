
resource "azurerm_container_registry_cache_rule" "this" {
  name                  = var.name
  container_registry_id = var.container_registry_id
  target_repo           = var.target_repo
  source_repo           = var.source_repo
  credential_set_id = var.credential_set_id
}
