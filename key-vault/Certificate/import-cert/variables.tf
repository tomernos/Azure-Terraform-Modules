variable "name" {
  type = string
}

variable "key_vault_id" {
  type = string
}

variable "certificate" {
  type = object({
    contents = string
    password = optional(string)
  })
}

variable "create" {
  type    = bool
  default = true
}