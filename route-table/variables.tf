
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
variable "name" {
  type    = string
}
variable "disable_bgp_route_propagation" {
  type    = bool
  default = null
}
variable "routes" {
  type    = any
  default = {}
}