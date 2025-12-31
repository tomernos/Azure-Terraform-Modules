variable "public_ip_names" {
  type = list(string)
  default = []
}

variable "firewall_network_rules" {
  type = any
  default = null
}

variable "create" {
  type = bool
  default = true
}

variable "location" {
  type = string
}



variable "rules" {
  type = any
}

variable "azure_firewall_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "action" {
  type = string
}
variable "name" {
  type = string
}

variable "idx" {
  type = number
  default = 150
}