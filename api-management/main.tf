resource "azurerm_api_management" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  publisher_name = var.publisher_name
  publisher_email = var.publisher_email
  sku_name = var.sku_name

  dynamic "additional_location" {
    for_each = var.additional_location
    content {
      location = additional_location.value.location
      capacity = additional_location.value.capacity
      zones = additional_location.value.zones
      public_ip_address_id = additional_location.value.public_ip_address_id

      dynamic "virtual_network_configuration" {
        for_each = additional_location.value.virtual_network_configuration
        content {
          subnet_id = virtual_network_configuration.value.subnet_id
        }
      }

      gateway_disabled = additional_location.value.gateway_disabled
    }
  }

  dynamic "certificate" {
    for_each = var.certificate
    content {
      encoded_certificate = certificate.value.encoded_certificate
      store_name = certificate.value.store_name
      certificate_password = certificate.value.certificate_password
    }
  }

  client_certificate_enabled = var.client_certificate_enabled

  dynamic "delegation" {
    for_each = var.delegation
    content {
      subscriptions_enabled = delegation.value.subscriptions_enabled
      user_registration_enabled = delegation.value.user_registration_enabled
      url = delegation.value.url
      validation_key = delegation.value.validation_key
    }
  }

  gateway_disabled = var.gateway_disabled
  min_api_version = var.min_api_version
  zones = var.zones

  dynamic "identity" {
    for_each = var.identity
    content {
      type = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  dynamic "hostname_configuration" {
    for_each = var.hostname_configuration
    content {
      dynamic "management" {
        for_each = hostname_configuration.value.management
        content {
          host_name = management.value.host_name
          key_vault_id = management.value.key_vault_id
          certificate = management.value.certificate
          certificate_password = management.value.certificate_password
          negotiate_client_certificate = management.value.negotiate_client_certificate
          ssl_keyvault_identity_client_id = management.value.ssl_keyvault_identity_client_id
        }
      }
      dynamic "portal" {
        for_each = hostname_configuration.value.portal
        content {
          host_name = portal.value.host_name
          key_vault_id = portal.value.key_vault_id
          certificate = portal.value.certificate
          certificate_password = portal.value.certificate_password
          negotiate_client_certificate = portal.value.negotiate_client_certificate
          ssl_keyvault_identity_client_id = portal.value.ssl_keyvault_identity_client_id
        }
      }
      dynamic "developer_portal" {
        for_each = hostname_configuration.value.developer_portal
        content {
          host_name = developer_portal.value.host_name
          key_vault_id = developer_portal.value.key_vault_id
          certificate = developer_portal.value.certificate
          certificate_password = developer_portal.value.certificate_password
          negotiate_client_certificate = developer_portal.value.negotiate_client_certificate
          ssl_keyvault_identity_client_id = developer_portal.value.ssl_keyvault_identity_client_id
        }
      }
      dynamic "proxy" {
        for_each = hostname_configuration.value.proxy
        content {
          default_ssl_binding = proxy.value.default_ssl_binding
          host_name = proxy.value.host_name
          key_vault_id = proxy.value.key_vault_id
          certificate = proxy.value.certificate
          certificate_password = proxy.value.certificate_password
          negotiate_client_certificate = proxy.value.negotiate_client_certificate
          ssl_keyvault_identity_client_id = proxy.value.ssl_keyvault_identity_client_id
        }
      }
      dynamic "scm" {
        for_each = hostname_configuration.value.scm
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
  }

  notification_sender_email = var.notification_sender_email

  dynamic "policy" {
    for_each = var.policy
    content {
      xml_content = policy.value.xml_content
      xml_link = policy.value.xml_link
    }
  }

  dynamic "protocols" {
    for_each = var.protocols
    content {
      enable_http2 = protocols.value.enable_http2
    }
  }

  dynamic "security" {
    for_each = var.security
    content {
      enable_backend_ssl30 = security.value.enable_backend_ssl30
      enable_backend_tls10 = security.value.enable_backend_tls10
      enable_backend_tls11 = security.value.enable_backend_tls11
      enable_frontend_ssl30 = security.value.enable_frontend_ssl30
      enable_frontend_tls10 = security.value.enable_frontend_tls10
      enable_frontend_tls11 = security.value.enable_frontend_tls11
      tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled = security.value.tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled
      tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled = security.value.tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled
      tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled = security.value.tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled
      tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled = security.value.tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled
      tls_rsa_with_aes128_cbc_sha256_ciphers_enabled = security.value.tls_rsa_with_aes128_cbc_sha256_ciphers_enabled
      tls_rsa_with_aes128_cbc_sha_ciphers_enabled = security.value.tls_rsa_with_aes128_cbc_sha_ciphers_enabled
      tls_rsa_with_aes128_gcm_sha256_ciphers_enabled = security.value.tls_rsa_with_aes128_gcm_sha256_ciphers_enabled
      tls_rsa_with_aes256_gcm_sha384_ciphers_enabled = security.value.tls_rsa_with_aes256_gcm_sha384_ciphers_enabled
      tls_rsa_with_aes256_cbc_sha256_ciphers_enabled = security.value.tls_rsa_with_aes256_cbc_sha256_ciphers_enabled
      tls_rsa_with_aes256_cbc_sha_ciphers_enabled = security.value.tls_rsa_with_aes256_cbc_sha_ciphers_enabled
      triple_des_ciphers_enabled = security.value.triple_des_ciphers_enabled
    }
  }

  dynamic "sign_in" {
    for_each = var.sign_in
    content {
      enabled = sign_in.value.enabled
    }
  }

  dynamic "sign_up" {
    for_each = var.sign_up
    content {
      enabled = sign_up.value.enabled
      dynamic "terms_of_service" {
        for_each = sign_up.value.terms_of_service
        content {
          consent_required = terms_of_service.value.consent_required
          enabled = terms_of_service.value.enabled
          text = terms_of_service.value.text
        }
      }
    }
  }

  dynamic "tenant_access" {
    for_each = var.tenant_access
    content {
      enabled = tenant_access.value.enabled
    }
  }

  public_ip_address_id = var.public_ip_address_id
  public_network_access_enabled = var.public_network_access_enabled
  virtual_network_type = var.virtual_network_type

  dynamic "virtual_network_configuration" {
    for_each = var.virtual_network_configuration
    content {
      subnet_id = virtual_network_configuration.value.subnet_id
    }
  }

  tags = var.tags

}

data "azurerm_api_management" "this" {
  name =  azurerm_api_management.this.name
  resource_group_name = var.resource_group_name
}

data "azurerm_client_config" "current" {}

data "azurerm_key_vault" "this" {
  for_each = var.key_vault
  name                = each.key
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_key_vault_access_policy" "this" {
  for_each = var.key_vault
  key_vault_id = data.azurerm_key_vault.this[each.key].id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_api_management.this.identity[0].principal_id
  certificate_permissions = ["Get", "List"]
  secret_permissions = ["Get", "List"]
}

module "custom_domain" {
  source = "./custom-domain"
  for_each = length(concat(
    var.custom_domains.developer_portal,
    var.custom_domains.management,
    var.custom_domains.portal,
    var.custom_domains.gateway,
    var.custom_domains.scm
  )) > 0 ? toset(["custom-domain"]) : []
  api_management_id = data.azurerm_api_management.this.id
  developer_portal = var.custom_domains.developer_portal
  management = var.custom_domains.management
  portal = var.custom_domains.portal
  gateway = var.custom_domains.gateway
  scm = var.custom_domains.scm
  depends_on = [azurerm_key_vault_access_policy.this]
}