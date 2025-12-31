variable "name" {
  type    = string
}
variable "resource_group_name" {
  type    = string
}
variable "location" {
  type    = string
}
variable "sku" {
  type    = string
}
variable "log_analytics_workspace_id" {
  type    = string
  default = null
}
variable "admin_enabled" {
  type    = bool
  default = false
}
variable "public_network_access_enabled" {
  type    = bool
  default = false
}
variable "georeplications" {
  type    = any
  default = {}
}
variable "network_rule_set" {
  type    = any
  default = {}
}
variable "trust_policy" {
  type    = any
  default = null
}
variable "retention_policy" {
  type    = any
  default = null
}
variable "identity" {
  type    = any
  default = null
}
variable "encryption" {
  type    = any
  default = null
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "private_endpoints" {
  type = any
  default = {}
}
variable "private_dns_zones" {
  type = any
  default = {}
}
variable "diagnostic_settings" {
  type = any
  default ={}
}
variable "subnet_id" {
  type = string
}
variable "retention_policy_in_days" {
  type = number
  default = 7
}
variable "zone_redundancy_enabled" {
  type = bool
  default = false
}
variable "tasks" {
  type = any
  default = {}

}
variable "credentials" {
  type = any
  default = {}
}
variable "cache_rules" {
  type = any
  default = {}
}