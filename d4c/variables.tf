variable "tier" {
  type    = string
}
variable "resource_type" {
  type    = string
  default = null
}
variable "extensions" {
  type    = any
  default = {}
}
variable "subplan" {
  type = any
  default = null
}