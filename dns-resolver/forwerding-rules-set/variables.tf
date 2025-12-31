variable "location" {
  type = string
}
variable "name" {
  type = string
}
variable "private_dns_resolver_outbound_endpoint_ids" {
  type = list(string)
}
variable "resource_group_name" {
  type = string
}
variable "tags" {
  type = map(string)
  default = {}
}
variable "forwarding_rules" {
  type = any
  default = {}
}
variable "vnets" {
  type = any
  default = null
}
variable "vnet_links" {
  type = any
  default = {}
}