variable "location" {
  type = string
}
variable "name" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "sku_name" {
  type = string
  default = "AZFW_VNet"

  validation {
    condition = anytrue([
      var.sku_name == "AZFW_Hub",
      var.sku_name == "AZFW_VNet"
    ])
    error_message =  "Specify desired sku name: AZFW_Hub or AZFW_VNet"
  }
}
variable "sku_tier" {
  type = string
  default = "Standard"

  validation {
    condition = anytrue ([
      var.sku_tier == "Basic",
      var.sku_tier == "Standard",
      var.sku_tier == "Premium"
    ])
    error_message =  "Specify desired sku tier: Basic, Standard, Premium"
  }
}
variable "firewall_policy_id" {
  type = string
  default = null
}
variable "ip_configuration" {
  description = "block"
  type = any
  default = null
}
variable "dns_servers" {
  description = "A list of DNS servers that the Azure Firewall will direct DNS traffic to the for name resolution."
  type = list(string)
  default = null
}
variable "private_ip_ranges" {
  type = list(string)
  default = null
}
variable "management_ip_configuration" {
  description = "block"
  type = any
  default = null
}
variable "threat_intel_mode" {
  type = string
  default = "Alert"

  validation {
    condition = anytrue([
      var.threat_intel_mode == "Off",
      var.threat_intel_mode == "Alert",
      var.threat_intel_mode == "Deny"
    ])
    error_message =  "Specify desired threat intel mode: Off, Alert, Deny"
  }
}
variable "virtual_hub" {
  description = "block"
  type = any
  default = null
}
variable "zones" {
  type = list(string)
  default = null
}
variable "tags" {
  type = map(string)
  default = {}
}
variable "firewall_policy" {
  type = any
  default =null
}
variable "diagnostic_settings" {
  type = any
  default ={}
}
variable "log_analytics_workspace_id" {
  type = string
  default =null
}
