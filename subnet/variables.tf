variable "virtual_network_name" {
  type = string
}
variable "subscription_id" {
  type = string
  default = ""
}

variable "resource_group_name" {
  type = string
}
variable "name" {
  type = string
}
variable "address_prefixes" {
  type = list(string)
}
variable "service_endpoints" {
  type    = list(string)
  default = []
}
variable "route_table" {
  type    = string
  default = ""
}
variable "delegation" {
  type = any
  default = {}
}
variable "network_security_group_id" {
  type = string
  default = null
}
variable "nat_gateway_id" {
  type = string
  default = null
}
variable "create_nat_gateway_association" {
  type = bool
  default = false
}
variable "nsg" {
  type = bool
  default = false
}
variable "private_endpoints" {
  type = any
  default = {}
}
variable "private_endpoint_network_policies" {
  type        = string
  description = "Enable or disable network policies for private endpoints on the subnet"
  default     = "Enabled" 
}