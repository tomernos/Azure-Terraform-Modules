variable "location" {
  type = string
}
variable "name" {
  type = string
}
variable "private_dns_resolver_id" {
  type = string
}
variable "subnet_id" {
  type = string
}
variable "tags" {
  type = map(string)
  default = {}
}
variable "ip_configurations" {
  type = any
  default = {}
}