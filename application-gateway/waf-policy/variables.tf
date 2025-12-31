# resource
variable "create" {
  type    = bool
  default = true
}
variable "name" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "custom_rules" {
  type    = any
  default = {}
}
variable "match_conditions" {
  type = any
  default = null
}
variable "managed_rules" {
  type    = any
  default = {}
}
variable "policy_settings" {
  type    = any
  default = {}
}
variable "rule_set_type" {
  type        = string
  default     = "OWASP"
}
variable "rule_set_version" {
  description = "The version of the managed rule set."
  type        = string
  default     = "3.2"
}
