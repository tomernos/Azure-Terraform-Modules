

variable "resource_group_name" {
  type    = string
  default = null

}
variable "name" {
  type    = string
  default = null
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "location" {
  type    = string
  default = null
}
variable "create" {
  type    = bool
  default = true
}
