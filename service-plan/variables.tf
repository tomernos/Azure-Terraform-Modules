
variable "location" {
  type    = string
}
variable "create" {
  type    = bool
  default = true
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "resource_group_name" {
  type    = string
}
variable "name" {
  type    = string
}

variable "os_type" {
  type    = string
}
variable "sku_name" {
  type    = string
  description = ""
}
variable "app_service_environment_id" {
  type    = string
  default = null
}
variable "maximum_elastic_worker_count" {
  type    = number
  default = null
  description  = "cannot be set unless using an elastic sku"
}
variable "worker_count" {
  type    = number
  default = null
}
variable "per_site_scaling_enabled" {
  type    = bool
  default = false
}
variable "zone_balancing_enabled" {
  type    = bool
  default = false
}