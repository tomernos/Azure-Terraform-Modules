variable "cdn_frontdoor_origin_group_id" {
  type = string
}
variable "name" {
  type = string
}
variable "host_name" {
  type = string
}
variable "enabled" {
  type = bool
  default = null
}
variable "certificate_name_check_enabled" {
  type = bool
}
variable "http_port" {
  type = number
  default = null
}
variable "https_port" {
  type = number
  default = null
}
variable "priority" {
  type = number
  default = null
}
variable "weight" {
  type = number
  default = null
}
variable "origin_host_header" {
  type = string
  default = null
}
variable "private_link" {
  type = any
  default = null
}
