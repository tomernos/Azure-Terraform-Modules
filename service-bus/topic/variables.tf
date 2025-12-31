variable "name" {
  type    = string
}

variable "namespace_id" {
  type    = string
}

variable "status" {
  type    = string
  default = null
}

variable "auto_delete_on_idle" {
  type    = string
  default = null
}

variable "default_message_ttl" {
  type    = string
  default = null
}

variable "duplicate_detection_history_time_window" {
  type    = string
  default = null
}

variable "enable_batched_operations" {
  type    = bool
  default = null
}

variable "enable_express" {
  type    = bool
  default = null
}

variable "enable_partitioning" {
  type    = bool
  default = null
}

variable "max_message_size_in_kilobytes" {
  type    = string
  default = null
}

variable "max_size_in_megabytes" {
  type    = string
  default = null
}

variable "requires_duplicate_detection" {
  type    = bool
  default = null
}

variable "support_ordering" {
  type    = bool
  default = null
}
