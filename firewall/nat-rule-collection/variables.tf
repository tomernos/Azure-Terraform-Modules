variable "firewall_config" {
  description = "Name of the Azure Firewall configuration."
  default = null
}

variable "public_ip_names" {
  type        = list(string)
  description = "List of names of public IPs."
  default = []
}

variable "fw_nat_rules" {
  type = any
  default = null
  description = "Map of Azure Firewall NAT rules."
}

variable "create" {
  type = bool
  default = true
}