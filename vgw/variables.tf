
# Required
# -----------
variable "create" {
  type = bool
  default = true
}
variable "name" {
  type = string
}
variable "location" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "sku" {
  type = string
}
variable "type" {
  description = "The type of the Virtual Network Gateway"
  type = string
  validation {
    condition = contains(["Vpn","ExpressRoute"], var.type)
    error_message = "Type must be \"Vpn\" or \"ExpressRoute\"."
  }
}
variable "public_ip_address_id" {
  description = "Related to ip_configuration"
  type = string
}
variable "subnet_id" {
  description = "Related to ip_configuration"
  type = string
}

# Required Blocks
# ------------------
variable "ip_configuration" {
  description = "An active-standby gateway requires exactly one ip_configuration block"
  type = list(object({
    name = string
  }))
}

# Optional
# -----------
variable "enable_bgp" {
  description = "Set true with site-2-site vpn towards OnPrem"
  type = bool
  default = false
}
variable "tags" {
  type = map(string)
  default = null
}

# Optional Blocks
# ------------------
variable "bgp_settings" {
  type = any
  default = null
}
variable "vpn_client_configuration" {
  type = any
  default = null
}
variable "custom_route" {
  type = any
  default = null
}
variable "local_gateway" {
  type = any
  default = {}
}
variable "connections" {
  type = any
  default = {}
}
