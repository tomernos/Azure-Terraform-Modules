variable "name" {
  type    = string
  default = null
}
variable "display_name" {
  type    = string
  default = null
}
variable "parent_management_group_id" {
  type    = string
  default = null
}
variable "subscription_ids" {
  type    = list(string)
  default = null
}