variable "api_management_id" {
  type = string
}
variable "management" {
  type = list(object({
    host_name = string
    certificate = optional(string)
    certificate_password = optional(string)
    key_vault_id = optional(string)
    negotiate_client_certificate = optional(bool)
    ssl_keyvault_identity_client_id = optional(string)
  }))
  default = []
}
variable "portal" {
  type = list(object({
    host_name = string
    certificate = optional(string)
    certificate_password = optional(string)
    key_vault_id = optional(string)
    negotiate_client_certificate = optional(bool)
    ssl_keyvault_identity_client_id = optional(string)
  }))
  default = []
}
variable "developer_portal" {
  type = list(object({
    host_name = string
    certificate = optional(string)
    certificate_password = optional(string)
    key_vault_id = optional(string)
    negotiate_client_certificate = optional(bool)
    ssl_keyvault_identity_client_id = optional(string)
  }))
  default = []
}
variable "gateway" {
  type = list(object({
    host_name = string
    certificate = optional(string)
    certificate_password = optional(string)
    default_ssl_binding = optional(bool)
    key_vault_id = optional(string)
    negotiate_client_certificate = optional(bool)
    ssl_keyvault_identity_client_id = optional(string)
  }))
  default = []
}
variable "scm" {
  type = list(object({
    host_name = string
    certificate = optional(string)
    certificate_password = optional(string)
    key_vault_id = optional(string)
    negotiate_client_certificate = optional(bool)
    ssl_keyvault_identity_client_id = optional(string)
  }))
  default = []
}