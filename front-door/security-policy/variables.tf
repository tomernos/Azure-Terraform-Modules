variable "cdn_frontdoor_profile_id" {
  type = string
}
variable "name" {
  type = string
}
variable "cdn_frontdoor_firewall_policy_id" {
  type = string
}
variable "domain_ids" {
  type = any
}
variable "patterns_to_match" {
  type = list(string)
}
