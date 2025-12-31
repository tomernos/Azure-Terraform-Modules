
variable "name" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
variable "tenant_id" {
  type = string
}
variable "enabled_for_deployment" {
  type = bool
  default = false
}
variable "public_network_access_enabled" {
  type = bool
  default = false
}
variable "enabled_for_disk_encryption" {
  type = bool
  default = false
}
variable "enabled_for_template_deployment" {
  type = bool
  default = false
}
variable "enable_rbac_authorization" {
  type = string
  default = true
}
variable "private_dns_zone_id" {
  type = string
  default = null
}
variable "subnet_id" {
  type = string
  default = null
}
variable "soft_delete_retention_days" {
  type = number
  default = null
}
variable "purge_protection_enabled" {
  type = bool
  default = true
}
variable "sku_name" {
  type = string
  default = "standard"
}
variable "contact" {
  type = any
  default = {}
}
variable "private_endpoints" {
  type = any
  default = {}
  
}
variable "network_acls" {
  type = any
  default = null
}
variable "private_dns_zones" {
  type = any
  default = null
}
variable "tags" {
  type = any
  default = null
}
