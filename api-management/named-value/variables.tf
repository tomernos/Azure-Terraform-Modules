variable "name" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "api_management_name" {
  type = string
}
variable "display_name" {
  type = string
}
variable "value" {
  type = string
  default = null
}
variable "value_from_key_vault" {
  type = list(object({
    secret_id = string
    identity_client_id = optional(string)
  }))
  default = []
}
variable "secret" {
  type = bool
  default = null
}
