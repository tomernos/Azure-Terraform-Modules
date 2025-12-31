variable "name" {
  type = string
}
variable "dns_forwarding_ruleset_id" {
  type = string
}
variable "domain_name" {
  type = string
}
variable "enabled" {
  type = bool
  default = null
}
variable "metadata" {
  type = any
  default = null
}
variable "target_dns_servers" {
  type = any
  default = {}
}