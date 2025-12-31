variable "create" {
  type    = bool
  default = true
}
variable "name" {
  type    = string
}
variable "resource_group_name" {
  type    = string
}
variable "location" {
  type    = string
}
variable "allocation_method" {
  type = string
  default = "Static"

  validation {
    condition = anytrue([
      var.allocation_method == "Static",
      var.allocation_method == "Dynamic"
    ])
    error_message = "allocation_method must be 'Static' or 'Dynamic'"
  }
}
variable "zones" {
  type = list(string)
  default = []
}
variable "ddos_protection_mode" {
  type = string
  default = "VirtualNetworkInherited"

  validation {
    condition = anytrue ([
      var.ddos_protection_mode == "Disabled",
      var.ddos_protection_mode == "Enabled",
      var.ddos_protection_mode == "VirtualNetworkInherited"
    ])
    error_message = "ddos_protection_mode must be: 'Disabled', 'Enabled', 'VirtualNetworkInherited'"
  }
}
variable "ddos_protection_plan_id" {
  description = "ddos_protection_plan_id can only be set when ddos_protection_mode is Enabled."
  type = string
  default = null
}
variable "domain_name_label" {
  type    = string
  default = null
}
variable "edge_zone" {
  type    = string
  default = null
}
variable "idle_timeout_in_minutes" {
  type    = string
  default = null
}
variable "ip_tags" {
  type    = map(string)
  default = {}
}
variable "ip_version" {
  type    = string
  default = null
}
variable "public_ip_prefix_id" {
  type    = string
  default = null
}
variable "reverse_fqdn" {
  type    = string
  default = null
}
variable "sku" {
  description = "Do not work with 'Basic'"
  type    = string
  default = "Standard"
}
variable "sku_tier" {
  type    = string
  default = "Regional"

  validation {
    condition = anytrue ([
      var.sku_tier == "Regional",
      var.sku_tier == "Global"
    ])
    error_message = "sku_tier must be: 'Regional' or 'Global'"
  }
}
variable "tags" {
  type    = map(string)
  default = {}
}
