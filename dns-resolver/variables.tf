
variable "name" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
variable "virtual_network_id" {
  type = string
}
variable "tags" {
  type = map(string)
  default = {}
}
variable "inbound_endpoints" {
  type = any
  default = {}
}
variable "subnets" {
  type = any
  default = null
}
variable "outbound_endpoints" {
  type = any
  default = {}
}
variable "vnets" {
  type = any
  default = null
}
