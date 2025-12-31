resource "azurerm_api_management_custom_domain" "this" {
  api_management_id = var.api_management_id

  dynamic "developer_portal" {
    for_each = var.developer_portal
    content {
      host_name = developer_portal.value.host_name
      certificate = developer_portal.value.certificate
      certificate_password = developer_portal.value.certificate_password
      key_vault_id = developer_portal.value.key_vault_id
      negotiate_client_certificate = developer_portal.value.negotiate_client_certificate
      ssl_keyvault_identity_client_id = developer_portal.value.ssl_keyvault_identity_client_id
    }
  }

  dynamic "management" {
    for_each = var.management
    content {
      host_name = management.value.host_name
      certificate = management.value.certificate
      certificate_password = management.value.certificate_password
      key_vault_id = management.value.key_vault_id
      negotiate_client_certificate = management.value.negotiate_client_certificate
      ssl_keyvault_identity_client_id = management.value.ssl_keyvault_identity_client_id
    }
  }
  dynamic "portal" {
    for_each = var.portal
    content {
      host_name = portal.value.host_name
      certificate = portal.value.certificate
      certificate_password = portal.value.certificate_password
      key_vault_id = portal.value.key_vault_id
      negotiate_client_certificate = portal.value.negotiate_client_certificate
      ssl_keyvault_identity_client_id = portal.value.ssl_keyvault_identity_client_id
    }
  }
  dynamic "gateway" {
    for_each = var.gateway
    content {
      host_name = gateway.value.host_name
      certificate = gateway.value.certificate
      certificate_password = gateway.value.certificate_password
      default_ssl_binding = gateway.value.default_ssl_binding
      key_vault_id = gateway.value.key_vault_id
      negotiate_client_certificate = gateway.value.negotiate_client_certificate
      ssl_keyvault_identity_client_id = gateway.value.ssl_keyvault_identity_client_id
    }
  }
  dynamic "scm" {
    for_each = var.scm
    content {
      host_name = scm.value.host_name
      key_vault_id = scm.value.key_vault_id
      certificate = scm.value.certificate
      certificate_password = scm.value.certificate_password
      negotiate_client_certificate = scm.value.negotiate_client_certificate
      ssl_keyvault_identity_client_id = scm.value.ssl_keyvault_identity_client_id
    }
  }
}