variable "name" {
  type = string
}
variable "dns_forwarding_ruleset_id" {
  type = string
}
variable "metadata" {
  type = any
  default = null
}
variable "virtual_network_id" {
  type = string
}