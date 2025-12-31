variable "name" {
  type    = string
}

variable "topic_id" {
  type    = string
}

variable "max_delivery_count" {
  type    = string
}

variable "auto_delete_on_idle" {
  type    = string
  default = null
}

variable "default_message_ttl" {
  type    = string
  default = null
}

variable "lock_duration" {
  type    = string
  default = null
}

variable "dead_lettering_on_message_expiration" {
  type    = bool
  default = null
}

variable "dead_lettering_on_filter_evaluation_error" {
  type    = bool
  default = null
}

variable "enable_batched_operations" {
  type    = bool
  default = null
}

variable "requires_session" {
  type    = bool
  default = null
}

variable "forward_to" {
  type    = string
  default = null
}

variable "forward_dead_lettered_messages_to" {
  type    = string
  default = null
}

variable "status" {
  type    = string
  default = null
}

variable "client_scoped_subscription_enabled" {
  type    = bool
  default = null
}
variable "client_scoped_subscription" {
  type    = any
  default = null
}
variable "rules" {
  type = any
  default = {}
}


