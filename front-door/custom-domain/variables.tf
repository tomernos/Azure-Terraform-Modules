
variable "tags" {
  type    = map(string)
  default = {}
}
variable "cdn_frontdoor_profile_id" {
  type = string
}
variable "name" {
  type = string
}
variable "dns_zone_id" {
  type = string
  default = null
}
variable "host_name" {
  type = string
}
variable "tls" {
  type = any
}
variable "create" {
  type = bool
  default = true
}
