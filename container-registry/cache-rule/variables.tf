variable "name" {
  type    = string
}
variable "container_registry_id" {
  type = string
}
variable "target_repo" {
  type = string
}
variable "source_repo" {
  type = string
}
variable "credential_set_id" {
  type = string
  default = null
}