variable "create" {
  type = bool
}
variable "name" {
  type = string
}
variable "api_management_name" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "revision" {
  type = string
}
variable "api_type" {
  type        = string
  validation {
    condition = var.api_type == null ? true : contains(["graphql","http","soap","websocket"], var.api_type)
    error_message = "Allowed values are graphql, http, soap or websocket"
  }
  default = null
}
variable "display_name" {
  type = string
  default = null
}
variable "path" {
  type = string
  default = null
}
variable "protocols" {
  type = list(string)
  validation {
    condition =  var.protocols == null ? true : alltrue([for protocol in var.protocols : contains(["http","https","ws","wss"], protocol)])
    error_message = "Allowed values are http, https, ws and wss"
  }
  default = null
}
variable "contact" {
  type = list(object({
    name = optional(string)
    email = optional(string)
    url = optional(string)
  }))
  default = []
}
variable "description" {
  type = string
  default = null
}
variable "import" {
  type = list(object({
    content_format = optional(string)
    content_value = optional(string)
    wsdl_selector = list(object({
      service_name = string
      endpoint_name = string
    }))
  }))
  default = []
}
variable "license" {
  type = list(object({
    name = optional(string)
    url = optional(string)
  }))
  default = []
}
variable "oauth2_authorization" {
  type = list(object({
    authorization_server_name = string
    scope = optional(string)
  }))
  default = []
}
variable "openid_authentication" {
  type = list(object({
    openid_provider_name = string
    bearer_token_sending_methods = optional(list(string))
  }))
  default = []
}
variable "service_url" {
  type = string
  default = null
}
variable "subscription_key_parameter_names" {
  type = list(object({
    header = string
    query = string
  }))
  default = []
}
variable "subscription_required" {
  type = bool
  default = null
}
variable "terms_of_service_url" {
  type = string
  default = null
}
variable "api_version" {
  type = string
  default = null
}
variable "version_set_id" {
  type = string
  default = null
}
variable "revision_description" {
  type = string
  default = null
}
variable "version_description" {
  type = string
  default = null
}
variable "source_api_id" {
  type = string
  default = null
}