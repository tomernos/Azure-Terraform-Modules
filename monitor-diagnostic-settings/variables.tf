variable "name" {
  type = string
}
variable "target_resource_id" {
  description = "The ID of an existing Resource on which to configure Diagnostic Settings. Changing this forces a new resource to be created."
  type = string
}
variable "eventhub_name" {
  description = "Specifies the name of the Event Hub where Diagnostics Data should be sent. If this isn't specified then the default Event Hub will be used."
  type = string
  default = null
}
variable "eventhub_authorization_rule_id" {
  description = "Specifies the ID of an Event Hub Namespace Authorization Rule used to send Diagnostics Data."
  type = string
  default = null
}
variable "enabled_log" {
  description = "block"
  type = any
  default = {}
}
variable "log_analytics_workspace_id" {
  type = string
  default = null
}
variable "metric" {
  description = "block"
  type = any
  default = {}
}
variable "storage_account_id" {
  type = string
  default = null
}
variable "log_analytics_destination_type" {
  type = string
  default = "AzureDiagnostics"

#  validation {
#    condition = anytrue ([
#      var.log_analytics_destination_type == "AzureDiagnostics",
#      var.log_analytics_destination_type == "Dedicated"
#    ])
#    error_message = "Specify desired log_analytics_destination_type: AzureDiagnostics or Dedicated"
#  }
}
variable "partner_solution_id" {
  description = "The ID of the market partner solution where Diagnostics Data should be sent."
  type = string
  default = null
}