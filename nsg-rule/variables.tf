variable "resource_group_name" {
  type    = string
}
variable "name" {
  type    = string
}
variable "priority" {
  type    = number
}
variable "network_security_group_name" {
  type    = string
}

variable "direction" {
  type    = string
  validation {
    condition = contains(["Inbound","Outbound"], var.direction)
    error_message = "Protocol must be Inbound or Outbound!" 
  }
}
variable "access" {
  type    = string
  validation {
    condition = contains(["Allow","Deny"], var.access)
    error_message = "Protocol must be Allow or Deny!"
  }
}
variable "protocol" {
  type    = string
  validation {
    condition = contains(["Tcp","Udp","Icmp","*"], var.protocol)
    error_message = "Protocol must be Tcp, Udp, Icmp or *!"
  }
}
variable "source_port_range" {
  type    = string
  default = null
}
variable "destination_port_range" {
  type    = string
  default = null
}
variable "destination_port_ranges" {
  type    = list(string)
  default = null
}
variable "source_address_prefix" {
  type    = string
  default = null
}
variable "destination_address_prefix" {
  type    = string
  default = null
}
variable "source_address_prefixes" {
  type    = list(string)
  default = null
}
variable "destination_address_prefixes" {
  type    = list(string)
  default = null
}
