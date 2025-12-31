
variable "name" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "create" {
  type = string
  default = true
}
variable "location" {
  type = string
}
variable "retention_in_days" {
  type = string
  default = 30
}
variable "sku" {
  type = string
  default = "PerGB2018"
}
variable "tags" {
  type    = map(string)
  default = {}
}
