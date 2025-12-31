# resource
variable "name" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "zones" {
  type    = list(number)
  default = []
}
variable "enable_http2" {
  type    = bool
  default = false
}
variable "force_firewall_policy_association" {
  type    = bool
  default = false
}

# dynamic
variable "backend_address_pool" {
  type = any
}
variable "backend_http_settings" {
  type = any
}
variable "frontend_ip_configuration" {
  type = any
}
variable "gateway_ip_configuration" {
  type = any
}
variable "frontend_port" {
  type = any
}
variable "http_listener" {
  type = any
}
variable "request_routing_rule" {
  type = any
}
variable "waf_configuration" {
  type = any
  default = {}
}
variable "probe" {
  type = any
  default = {}
}
variable "rewrite_rule_set" {
  type = any
  default = {}
}
variable "ssl_policy" {
  type = any
  default = {}
}
variable "subnet_id" {
  type    = string
  default = null
}
variable "public_ip_address_id" {
  type    = string
  default = null
}
variable "sku" {
  type = any
}
variable "ssl_certificate" {
  type = any
  default = {}
}
variable "url_path_map" {
  type = any
  default = null
}
variable "autoscale_configuration" {
  type = any
  default = null
}
variable "identity" {
  type = any
  default = null
}
variable "identity_ids" {
  type = list(string)
  default = []
}
variable "firewall_policy_id" {
  type = string
  default = null
}
