variable "name" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "sku_name" {
  type = string
}
variable "mode" {
  type = string
}
variable "redirect_url" {
  type = string
  default = null
}
variable "create" {
  type = bool
  default = true
}
variable "custom_block_response_status_code" {
  type = string
  default = null
}
variable "custom_block_response_body" {
  type = any
  default = null
}
variable "enabled" {
  type = bool
  default = null
}
variable "request_body_check_enabled" {
  type = bool
  default = null
}
variable "tags" {
  type = map(string)
  default = {}
}
variable "custom_rule" {
  type = any
  default = {}
}
variable "managed_rule" {
  type = any
  default = {}
}