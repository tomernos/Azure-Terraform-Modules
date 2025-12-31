variable "identifier" {
  type = string
}
variable "api_management_name" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "api_management_logger_id" {
  type = string
}
variable "always_log_errors" {
  type = bool
  default = null
}
variable "backend_request" {
  type = list(object({
    body_bytes = optional(string)
    headers_to_log = optional(string)
    data_masking = optional(list(object({
      query_params = optional(list(object({
        mode = string
        value = string
      })))
      headers = optional(list(object({
        mode = string
        value = string
      })))
    })))
  }))
  default = []
}
variable "backend_response" {
  type = list(object({
    body_bytes = optional(string)
    headers_to_log = optional(string)
    data_masking = optional(list(object({
      query_params = optional(list(object({
        mode = string
        value = string
      })))
      headers = optional(list(object({
        mode = string
        value = string
      })))
    })))
  }))
  default = []
}
variable "frontend_request" {
  type = list(object({
    body_bytes = optional(string)
    headers_to_log = optional(string)
    data_masking = optional(list(object({
      query_params = optional(list(object({
        mode = string
        value = string
      })))
      headers = optional(list(object({
        mode = string
        value = string
      })))
    })))
  }))
  default = []
}
variable "frontend_response" {
  type = list(object({
    body_bytes = optional(string)
    headers_to_log = optional(string)
    data_masking = optional(list(object({
      query_params = optional(list(object({
        mode = string
        value = string
      })))
      headers = optional(list(object({
        mode = string
        value = string
      })))
    })))
  }))
  default = []
}
variable "http_correlation_protocol" {
  type        = string
  validation {
    condition = var.http_correlation_protocol == null ? true : contains(["None","Legacy","W3C"], var.http_correlation_protocol)
    error_message = "Allowed values are None, Legacy or W3C"
  }
  default = null
}
variable "log_client_ip" {
  type = string
  default = null
}
variable "sampling_percentage" {
  type = string
  default = null
}
variable "verbosity" {
  type        = string
  validation {
    condition = var.verbosity == null ? true : contains(["verbose","information","error"], var.verbosity)
    error_message = "Allowed values are verbose, information or error"
  }
  default = null
}
variable "operation_name_format" {
  type        = string
  validation {
    condition = var.operation_name_format == null ? true : contains(["Name","Url"], var.operation_name_format)
    error_message = "Allowed values are Name or Url"
  }
  default = null
}