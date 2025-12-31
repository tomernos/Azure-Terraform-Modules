variable "location" {
  type = string
}
variable "name" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "public_ip_address_id" {
  type = string
  default = null
}
variable "private_ip_ranges" {
  type = list(string)
  default = null
}
variable "tags" {
  type = map(string)
  default = {}
}
variable "rule_collections" {
  type = any
  default = {}
}