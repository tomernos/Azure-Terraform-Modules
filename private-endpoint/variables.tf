
variable "name" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
variable "private_dns_zone_id" {
  type = string
  default = null
}
variable "subnet_id" {
  type = string
}
variable "custom_network_interface_name" {
  type = string
  default = null
}
variable "private_dns_zone_group" {
  type = any
  default = null
}
variable "private_service_connection" {
  type = any
  default = {}
}
variable "ip_configuration" {
  type = any
  default = {}
}