variable "public_ip_names" {
  type    = list(string)
  default = ["public_ip_1", "public_ip_2", "public_ip_3"]
}

variable "firewall_application_rules" {
  type    = any
  default = null
}

variable "firewall_config" {
  type    = string
  default = "default"
}

variable "create" {
  type = bool
  default = true
}