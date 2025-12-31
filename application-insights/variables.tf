variable "resource_group_name" {
  type    = string
  default = null

}
variable "name" {
  type    = string
  default = null
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "location" {
  type    = string
}
variable "workspace_id" {
  type    = string
  default = null
}
variable "retention_in_days" {
  type    = number
  default = 90
}
variable "daily_data_cap_in_gb" {
  type    = number
  default = null
}
variable "application_type" {
  type    = string
}
variable "sampling_percentage" {
  type    = number
  default = 100
}
variable "disable_ip_masking" {
  type    = any
  default = null
}
variable "local_authentication_disabled" {
  type    = bool
  default = false
}
variable "internet_ingestion_enabled" {
  type    = bool
  default = true
}
variable "internet_query_enabled" {
  type    = bool
  default = true
}
variable "create" {
  type    = bool
  default = true
}
variable "force_customer_storage_for_profiler" {
  type    = bool
  default = false
}
