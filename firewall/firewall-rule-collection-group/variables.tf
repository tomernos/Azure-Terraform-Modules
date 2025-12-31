
variable "firewall_policy_id" {
  type = string
}
variable "public_ip_address_id" {
  type = string
  default = null
}
variable "name" {
  type = string
}
variable "priority" {
  type = number
}
variable "create" {
  type = bool
  default = true
}
variable "application_rule_collection" {
  type = any
  default = {}
}
variable "nat_rule_collection" {
  type = any
  default = {}
}
variable "network_rule_collection" {
  type = any
  default = {}
}