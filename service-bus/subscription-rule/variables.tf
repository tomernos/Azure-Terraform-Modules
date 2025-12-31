variable "name" {
  type    = string
}
variable "subscription_id" {
  type    = string
}
variable "filter_type" {
  type    = string
  default = "SqlFilter"
}
variable "action" {
  type    = string
  default = null
}
variable "sql_filter" {
  type    = string
  default = null
}
variable "correlation_filter" {
  type = any
  default = {}
}