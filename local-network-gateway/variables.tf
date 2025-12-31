
variable "name" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
variable "address_space" {
  type    = list(string)
  default = []
}
variable "gateway_address" {
  type    = string
  default = null
}
variable "gateway_fqdn" {
  type    = string
  default = null
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "bgp_settings" {
  description = "bgp_peering_address: Azure-reserved APIPA address range for VPN, which is from 169.254.21.0 to 169.254.22.255"
  type = object({
    asn                 = number
    bgp_peering_address = string
    peer_weight         = optional(string)
  })
  default = null
}
