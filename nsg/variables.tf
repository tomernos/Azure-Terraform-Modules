
variable "location" {
  type    = string
  default = null
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "resource_group_name" {
  type    = string
  default = ""
}
variable "create" {
  type    = bool
  default = true
}
variable "name" {
  type    = string
  default = ""
}