variable "operation_id" {
  type = string
}
variable "api_name" {
  type = string
}
variable "api_management_name" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "display_name" {
  type = string
}
variable "method" {
  type = string
}
variable "url_template" {
  type = string
}
variable "description" {
  type = string
  default = null
}
variable "request" {
  type = list(object({
    description = optional(string)
    header = optional(list(object({
      name = string
      required = bool
      type = string
      description = optional(string)
      default_value = optional(string)
      values = optional(list(string))
      schema_id = optional(string)
      type_name = optional(string)
      example = optional(list(object({
        name = string
        summary = optional(string)
        description = optional(string)
        value = optional(string)
        external_value = optional(string)
      })))
    })))
    query_parameter = optional(list(object({
      name = string
      required = bool
      type = string
      description = optional(string)
      default_value = optional(string)
      values = optional(list(string))
      schema_id = optional(string)
      type_name = optional(string)
      example = optional(list(object({
        name = string
        summary = optional(string)
        description = optional(string)
        value = optional(string)
        external_value = optional(string)
      })))
    })))
    representation = optional(list(object({
      content_type = string
      schema_id = optional(string)
      type_name = optional(string)
      form_parameter = optional(list(object({
        name = string
        required = bool
        type = string
        description = optional(string)
        default_value = optional(string)
        values = optional(list(string))
        schema_id = optional(string)
        type_name = optional(string)
        example = optional(list(object({
          name = string
          summary = optional(string)
          description = optional(string)
          value = optional(string)
          external_value = optional(string)
        })))
      })))
      example = optional(list(object({
        name = string
        summary = optional(string)
        description = optional(string)
        value = optional(string)
        external_value = optional(string)
      })))
    })))
  }))
  default = []
}
variable "response" {
  type = list(object({
    status_code = number
    description = optional(string)
    header = optional(list(object({
      name = string
      required = bool
      type = string
      description = optional(string)
      default_value = optional(string)
      values = optional(list(string))
      schema_id = optional(string)
      type_name = optional(string)
      example = optional(list(object({
        name = string
        summary = optional(string)
        description = optional(string)
        value = optional(string)
        external_value = optional(string)
      })))
    })))
    representation = optional(list(object({
      content_type = string
      schema_id = optional(string)
      type_name = optional(string)
      form_parameter = optional(list(object({
        name = string
        required = bool
        type = string
        description = optional(string)
        default_value = optional(string)
        values = optional(list(string))
        schema_id = optional(string)
        type_name = optional(string)
        example = optional(list(object({
          name = string
          summary = optional(string)
          description = optional(string)
          value = optional(string)
          external_value = optional(string)
        })))
      })))
      example = optional(list(object({
        name = string
        summary = optional(string)
        description = optional(string)
        value = optional(string)
        external_value = optional(string)
      })))
    })))
  }))
  default = []
}
variable "template_parameter" {
  type = list(object({
    name = string
    required = bool
    type = string
    description = optional(string)
    default_value = optional(string)
    values = optional(list(string))
    schema_id = optional(string)
    type_name = optional(string)
    example = optional(list(object({
      name = string
      summary = optional(string)
      description = optional(string)
      value = optional(string)
      external_value = optional(string)
    })))
  }))
  default = []
}