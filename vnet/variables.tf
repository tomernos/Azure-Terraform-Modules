
variable "location" {
  type = string
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "resource_group_name" {
  type = string
}
variable "name" {
  type = string
}
variable "dns_servers" {
  type    = list(string)
  default = null
}
variable "address_space" {
  type = list(string)
}
variable "ddos_protection_plan" {
  type = list(object({
    id = string
    enable = bool
  }))
  default = []
}