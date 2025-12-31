variable "name" {
    type        = string
}

variable "create" {
    type        = bool
    default     = true
}

variable "parameters" {
    type        = any
    default     = null
}
variable "metadata" {
    type        = any
    default     = null
}
variable "policy_rule" {
    type        = any
    default = null
}
variable "description" {
  type        = string
  default     = null
}
variable "policy_type" {
  type        = string
  default     = "Custom"
}
variable "mode" {
  type        = string
  default     = "All"
}
variable "management_group_name" {
  type        = string
  default     = null
}
variable "display_name" {
  type        = string
}




