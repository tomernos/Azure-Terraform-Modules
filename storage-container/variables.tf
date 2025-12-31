variable "create" {
  type    = bool
  default = true
}
variable "container_access_type" {
  type    = string
  default = "private"
}
variable "storage_account_id" {
  type = string
}
variable "name" {
  type = string
}
variable "metadata" {
  type    = map(string)
  default = null
}