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
variable "enabled_log" {
  type    = any
  default = {}
}