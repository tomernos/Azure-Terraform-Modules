
variable "tags" {
  type    = map(string)
  default = {}
}
variable "resource_group_name" {
  type = string
}
variable "create" {
  type = bool
  default = true
}
variable "name" {
  type = string
}
variable "sku_name" {
  type = string
}
variable "cdn_frontdoor_firewall_policy_id" {
  type = string
  default = null
}
variable "response_timeout_seconds" {
  type = string
  default = null
}
variable "custom_domain" {
  type = any
  default = {}
}
variable "security_policies" {
  type = any
  default = {}
}
variable "origin_groups" {
  type = any
  default = {}
}
variable "waf_policies" {
  type = any
  default = {}
}
variable "rule_sets" {
  type = any
  default = {}
}
variable "endpoints" {
  type = any
  default = {}
}
variable "routes" {
  type = any
  default = {}
}
variable "diagnostic_settings" {
  type = any
  default = {}
}
