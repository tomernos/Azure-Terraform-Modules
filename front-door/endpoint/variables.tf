variable "cdn_frontdoor_profile_id" {
  type = string
}
variable "name" {
  type = string
}
variable "enabled" {
  type = bool
  default = null
}
variable "create" {
  type = bool
  default = true
}
variable "tags" {
  type = map(string)
  default = {}
}
