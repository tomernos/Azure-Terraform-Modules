resource "azurerm_key_vault" "this" {
  name                            = var.name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  enabled_for_deployment          = var.enabled_for_deployment
  tenant_id                       = var.tenant_id
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  public_network_access_enabled   = var.public_network_access_enabled
  enabled_for_template_deployment = var.enabled_for_template_deployment
  enable_rbac_authorization       = var.enable_rbac_authorization
  soft_delete_retention_days      = var.soft_delete_retention_days
  purge_protection_enabled        = var.purge_protection_enabled
  sku_name                        = var.sku_name
  tags                            = var.tags

}

data "azurerm_role_definition" "certificates_officer" {
  name  = "Key Vault Secrets Officer"
  scope = azurerm_key_vault.this.id
}

resource "azurerm_role_assignment" "keyvault_admin" {
  scope              = azurerm_key_vault.this.id
  role_definition_id = data.azurerm_role_definition.certificates_officer.id
  principal_id       = "9fad1231-d4f4-4a74-aa47-16f3e813fa4a" # Microsoft.Azure.CertificateRegistration
}

module "private-endpoints" {
  source              = "../../private-endpoint"
  for_each            = var.private_endpoints
  name                = each.key
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = var.subnet_id

  private_dns_zone_group = {
    name                 = "default"
    private_dns_zone_ids = ["/subscriptions/2fb7c417-b617-4d1f-b82d-9fcb42bcc663/resourceGroups/rg-vnet-westus3-mgmt/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net"]
  }
  private_service_connection = merge(each.value.private_service_connection,
    {
      private_connection_resource_id = azurerm_key_vault.this.id
      subresource_names              = ["vault"]
  })
}
