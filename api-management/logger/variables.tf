variable "name" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "api_management_name" {
  type = string
}
variable "application_insights" {
  type = list(object({
    instrumentation_key = string
  }))
  default = []
}
variable "buffered" {
  type = bool
  default = null
}
variable "description" {
  type = string
  default = null
}
variable "eventhub" {
  type = list(object({
    name = string
    connection_string = optional(string)
    user_assigned_identity_client_id = optional(string)
    endpoint_uri = optional(string)
  }))
  default = []
}
variable "resource_id" {
  type = string
  default = null
}