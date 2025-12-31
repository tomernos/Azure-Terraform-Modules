variable "location" {
  type = string
}
variable "name" {
  type = string
}
variable "private_dns_resolver_id" {
  type = string
}
variable "subnet_id" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "forwarding_ruleset" {
  type = any
  default = {}
}
variable "tags" {
  type = map(string)
  default = {}
}
variable "vnets" {
  type = any
  default = null
}