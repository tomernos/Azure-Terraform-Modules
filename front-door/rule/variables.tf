variable "cdn_frontdoor_rule_set_id" {
  type = string
}
variable "name" {
  type = string
}
variable "order" {
  type = string
}
variable "behavior_on_match" {
  type = string
  default = null
}
variable "actions" {
  type = any
}
variable "conditions" {
  type = any
  default = null
}