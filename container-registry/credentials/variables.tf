variable "name" {
  type    = string
}
variable "container_registry_id" {
  type = string
}
variable "login_server" {
  type = string
}
variable "authentication_credentials" {
  type = object({
    username_secret_id = string
    password_secret_id = string
  })
}
