
variable "location" {
  type    = string
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "resource_group_name" {
  type    = string
}
variable "subnet_id" {
  type    = string
  default = null
}
variable "namespace_name" {
  type    = string
}
variable "sku" {
  type    = string
}
variable "premium_messaging_partitions" {
  type    = string
  default = null
}
variable "minimum_tls_version" {
  type    = string
  default = null
}
variable "capacity" {
  type    = number
  default = null
}
variable "local_auth_enabled" {
  type    = bool
  default = true
}
variable "public_network_access_enabled" {
  type    = bool
  default = true
}
variable "zone_redundant" {
  type    = bool
  default = false
}
variable "identity" {
  type    = any
  default = {}
}
variable "customer_managed_key" {
  type    = any
  default = {}
}
variable "private_dns_zones" {
  type    = any
  default = {}
}
variable "queues" {
  type    = any
  default = {}
}
variable "topics" {
  type    = any
  default = {}
}
variable "private_endpoint" {
  type    = bool
  default = false
}
variable "subscriptions" {
  type    = any
  default = {}
}
variable "subscription" {
  type    = any
  default = {}
}
variable "network_rule_set" {
  type    = any
  default = {}
}