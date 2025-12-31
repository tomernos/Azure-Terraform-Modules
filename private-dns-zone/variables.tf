
variable "name" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "virtual_network_id" {
  type = string
  default = null
}
variable "dns_zone_subscription_id" {
  type = string
  default = null
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "subscriptions" {
  type    = map(string)
  default = {}
}

variable "environment" {
  type = string
}
variable "linked_envs" {
  type = list(string)
}