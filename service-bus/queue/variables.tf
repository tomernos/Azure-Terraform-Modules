variable "name" {
  type        = string
}

variable "namespace_id" {
  type        = string
}

variable "lock_duration" {
  type        = string
  default     = null
}

variable "max_message_size_in_kilobytes" {
  type        = string
  default     = null
}

variable "max_size_in_megabytes" {
  type        = string
  default     = null
}

variable "requires_duplicate_detection" {
  type        = bool
  default     = null
}

variable "requires_session" {
  type        = bool
  default     = null
}

variable "default_message_ttl" {
  type        = string
  default     = null
}

variable "dead_lettering_on_message_expiration" {
  type        = bool
  default     = null
}

variable "duplicate_detection_history_time_window" {
  type        = string
  default     = null
}

variable "max_delivery_count" {
  type        = string
  default     = 10
}

variable "status" {
  type        = string
  default     = null
}

variable "enable_batched_operations" {
  type        = bool
  default     = null
}

variable "auto_delete_on_idle" {
  type        = string
  default     = null
}

variable "enable_partitioning" {
  type        = bool
  default     = null
}

variable "enable_express" {
  type        = bool
  default     = false
}

variable "forward_to" {
  type        = string
  default     = null
}

variable "forward_dead_lettered_messages_to" {
  type        = string
  default     = null
}
