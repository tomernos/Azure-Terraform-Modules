variable "target_resource_id" {
  type    = string
}
variable "name" {
  type    = string
}
variable "eventhub_name" {
  type    = string
  default = null
}
variable "eventhub_authorization_rule_id" {
  type    = string
  default = null
}
variable "log_analytics_workspace_id" {
  type    = string
  default = null
}
variable "storage_account_id" {
  type    = string
  default = null
}
variable "log_analytics_destination_type" {
  type    = string
  default = null
}
variable "partner_solution_id" {
  type    = string
  default = null
}
variable "enabled_log" {
  type    = any
  default = {}
}
variable "metric" {
  type    = any
  default = {}
}