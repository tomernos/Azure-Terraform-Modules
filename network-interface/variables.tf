variable "subnet_id" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "location" {
  type    = string
}
variable "name" {
  type = string
}
variable "tags" {
  type = map(string)
  default = null
}
variable "ip_configuration" {
  type = any
  default = null
}
variable "private_ip_address_allocation" {
  type    = string
  default = "Dynamic"
}
variable "accelerated_networking_enabled" {
  type    = bool
  default = true
}