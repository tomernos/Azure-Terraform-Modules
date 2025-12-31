variable "cdn_frontdoor_profile_id" {
  type = string
}
variable "name" {
  type = string
}
variable "create" {
  type = bool
  default = true
}
variable "rules" {
  type = any
  default = {}
}