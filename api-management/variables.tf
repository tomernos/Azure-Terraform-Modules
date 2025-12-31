
variable "name" {
  type        = string
}
variable "location" {
  type        = string
}
variable "resource_group_name" {
  type        = string
}
variable "publisher_name" {
  type        = string
}
variable "publisher_email" {
  type        = string
}
variable "sku_name" {
  type        = string
  validation {
    condition     = can(regex("^(Consumption|Developer|Basic|Standard|Premium)_[0-9][0-9]*$", var.sku_name))
    error_message = "The sku_name must be in the format 'Name_Capacity', where Name is one of 'Consumption', 'Developer', 'Basic', 'Standard', 'Premium', and Capacity is a positive integer."
  }
}
variable "additional_location" {
  type = list(object({
    location = string
    capacity = optional(number)
    zones = optional(list(string))
    public_ip_address_id = optional(string)
    virtual_network_configuration = optional(object({
      subnet_id = string
    }))
    gateway_disabled = optional(bool)
  }))
  default = []
}
variable "certificate" {
  type = list(object({
    encoded_certificate = string
    store_name = string
    certificate_password = optional(string)
  }))
  default = []
}
variable "client_certificate_enabled" {
  type = bool
  default = null
}
variable "delegation" {
  type = list(object({
    subscriptions_enabled = optional(string)
    user_registration_enabled = optional(string)
    url = optional(string)
    validation_key = optional(string)
  }))
  default = []
}
variable "gateway_disabled" {
  type = bool
  default = null
}
variable "min_api_version" {
  type = string
  default = null
}
variable "zones" {
  type = list(string)
  default = null
}
variable "identity" {
  type = list(object({
    type = string
    identity_ids = optional(list(string))
  }))
  default = []
}
variable "hostname_configuration" {
  type = list(object({
    management = optional(list(object({
      host_name = string
      key_vault_id = optional(string)
      certificate = optional(string)
      certificate_password = optional(string)
      negotiate_client_certificate = optional(bool)
      ssl_keyvault_identity_client_id = optional(string)
    })))
    portal = optional(list(object({
      host_name = string
      key_vault_id = optional(string)
      certificate = optional(string)
      certificate_password = optional(string)
      negotiate_client_certificate = optional(bool)
      ssl_keyvault_identity_client_id = optional(string)
    })))
    developer_portal = optional(list(object({
      host_name = string
      key_vault_id = optional(string)
      certificate = optional(string)
      certificate_password = optional(string)
      negotiate_client_certificate = optional(bool)
      ssl_keyvault_identity_client_id = optional(string)
    })))
    proxy = optional(list(object({
      default_ssl_binding = optional(bool)
      host_name = string
      key_vault_id = optional(string)
      certificate = optional(string)
      certificate_password = optional(string)
      negotiate_client_certificate = optional(bool)
      ssl_keyvault_identity_client_id = optional(string)
    })))
    scm = optional(list(object({
      host_name = string
      key_vault_id = optional(string)
      certificate = optional(string)
      certificate_password = optional(string)
      negotiate_client_certificate = optional(bool)
      ssl_keyvault_identity_client_id = optional(string)
    })))
  }))
  default = []
}
variable "notification_sender_email" {
  type = string
  default = null
}
variable "policy" {
  type = list(object({
    xml_content = optional(string)
    xml_link = optional(string)
  }))
  default = []
}
variable "protocols" {
  type = list(object({
    enable_http2 = optional(bool)
  }))
  default = []
}
variable "security" {
  type = list(object({
    enable_backend_ssl30 = optional(bool)
    enable_backend_tls10 = optional(bool)
    enable_backend_tls11 = optional(bool)
    enable_frontend_ssl30 = optional(bool)
    enable_frontend_tls10 = optional(bool)
    enable_frontend_tls11 = optional(bool)
    tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled = optional(bool)
    tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled = optional(bool)
    tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled = optional(bool)
    tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled = optional(bool)
    tls_rsa_with_aes128_cbc_sha256_ciphers_enabled = optional(bool)
    tls_rsa_with_aes128_cbc_sha_ciphers_enabled = optional(bool)
    tls_rsa_with_aes128_gcm_sha256_ciphers_enabled = optional(bool)
    tls_rsa_with_aes256_gcm_sha384_ciphers_enabled = optional(bool)
    tls_rsa_with_aes256_cbc_sha256_ciphers_enabled = optional(bool)
    tls_rsa_with_aes256_cbc_sha_ciphers_enabled = optional(bool)
    triple_des_ciphers_enabled = optional(bool)
  }))
  default = []
}
variable "sign_in" {
  type = list(object({
    enabled = bool
  }))
  default = []
}
variable "sign_up" {
  type = list(object({
    enabled = bool
    terms_of_service = list(object({
      consent_required = bool
      enabled = bool
      text = optional(string)
    }))
  }))
  default = []
}
variable "tenant_access" {
  type = list(object({
    enabled = bool
  }))
  default = []
}
variable "public_ip_address_id" {
  type = string
  default = null
}
variable "public_network_access_enabled" {
  type = bool
  default = null
}
variable "virtual_network_type" {
  type        = string
  validation {
    condition = contains(["None","External","Internal"], var.virtual_network_type)
    error_message = "Allowed values are None, External or Internal"
  }
  default = null
}
variable "virtual_network_configuration" {
  type = list(object({
    subnet_id = string
  }))
  default = []
}
variable "tags" {
  type = map(string)
  default = {}
}

variable "custom_domains" {
  type = object({
    management = optional(list(object({
      host_name = string
      certificate = optional(string)
      certificate_password = optional(string)
      key_vault_id = optional(string)
      negotiate_client_certificate = optional(bool)
      ssl_keyvault_identity_client_id = optional(string)
    })), [])
    portal = optional(list(object({
      host_name = string
      certificate = optional(string)
      certificate_password = optional(string)
      key_vault_id = optional(string)
      negotiate_client_certificate = optional(bool)
      ssl_keyvault_identity_client_id = optional(string)
    })), [])
    developer_portal = optional(list(object({
      host_name = string
      certificate = optional(string)
      certificate_password = optional(string)
      key_vault_id = optional(string)
      negotiate_client_certificate = optional(bool)
      ssl_keyvault_identity_client_id = optional(string)
    })), [])
    gateway = optional(list(object({
      host_name = string
      certificate = optional(string)
      certificate_password = optional(string)
      default_ssl_binding = optional(bool)
      key_vault_id = optional(string)
      negotiate_client_certificate = optional(bool)
      ssl_keyvault_identity_client_id = optional(string)
    })), [])
    scm = optional(list(object({
      host_name = string
      certificate = optional(string)
      certificate_password = optional(string)
      key_vault_id = optional(string)
      negotiate_client_certificate = optional(bool)
      ssl_keyvault_identity_client_id = optional(string)
    })), [])
  })
  default = {
    management = []
    portal = []
    developer_portal = []
    gateway = []
    scm = []
  }
}


variable "key_vault" {
  type = map(object({
    resource_group_name = string
  }))
  default = {}
}

