variable "name" {
  type = string
}
variable "dns_forwarding_ruleset_id" {
  type = string
}
variable "virtual_network_id" {
  type = string
}
variable "metadata" {
  type = map(string)
  default = null
}
