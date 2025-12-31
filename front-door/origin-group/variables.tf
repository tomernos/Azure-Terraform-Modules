
variable "tags" {
  type    = map(string)
  default = {}
}
variable "cdn_frontdoor_profile_id" {
  type = string
}
variable "create" {
  type = bool
  default = true
}
variable "name" {
  type = string
}
variable "session_affinity_enabled" {
  type = bool
  default = null
}
variable "restore_traffic_time_to_healed_or_new_endpoint_in_minutes" {
  type = number
  default = null
}
variable "health_probe" {
  type = any
  default = null
}
variable "load_balancing" {
  type = any
}
variable "origins" {
  type = any
  default = {}
}
