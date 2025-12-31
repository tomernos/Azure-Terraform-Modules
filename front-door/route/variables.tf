variable "cdn_frontdoor_endpoint_id" {
  type = string
}
variable "cdn_frontdoor_origin_ids" {
  type = list(string)
}
variable "cdn_frontdoor_origin_group_id" {
  type = string
}
variable "name" {
  type = string
}
variable "forwarding_protocol" {
  type = string
  default = null
}
variable "cdn_frontdoor_origin_path" {
  type = string
  default = null
}
variable "patterns_to_match" {
  type = list(string)
}
variable "supported_protocols" {
  type = list(string)
}
variable "cdn_frontdoor_custom_domain_ids" {
  type = list(string)
  default = null
}
variable "cdn_frontdoor_rule_set_ids" {
  type = list(string)
  default = null
}
variable "enabled" {
  type = bool
  default = null
}
variable "https_redirect_enabled" {
  type = bool
  default = null
}
variable "link_to_default_domain" {
  type = bool
  default = null
}
variable "cache" {
  type = any
  default = null
}
