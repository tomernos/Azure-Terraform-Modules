resource "azurerm_api_management_api_operation" "this" {
  operation_id = var.operation_id
  api_name = var.api_name
  api_management_name = var.api_management_name
  resource_group_name = var.resource_group_name
  display_name = var.display_name
  method = var.method
  url_template = var.url_template
  description = var.description

  dynamic "request" {
    for_each = var.request
    content {
      description = request.value.description
      dynamic "header" {
        for_each = request.value.header
        content {
          name = header.value.name
          required = header.value.required
          type = header.value.type
          description = header.value.description
          default_value = header.value.default_value
          values = header.value.values
          schema_id = header.value.schema_id
          type_name = header.value.type_name
          dynamic "example" {
            for_each = header.value.example
            content {
              name = example.value.name
              summary = example.value.summary
              description = example.value.description
              value = example.value.value
              external_value = example.value.external_value
            }
          }
        }
      }

      dynamic "query_parameter" {
        for_each = request.value.query_parameter
        content {
          name = query_parameter.value.name
          required = query_parameter.value.required
          type = query_parameter.value.type
          description = query_parameter.value.description
          default_value = query_parameter.value.default_value
          values = query_parameter.value.values
          schema_id = query_parameter.value.schema_id
          type_name = query_parameter.value.type_name
          dynamic "example" {
            for_each = query_parameter.value.example
            content {
              name = example.value.name
              summary = example.value.summary
              description = example.value.description
              value = example.value.value
              external_value = example.value.external_value
            }
          }
        }
      }
      dynamic "representation" {
        for_each = request.value.representation
        content {
          content_type = representation.value.content_type
          schema_id = representation.value.schema_id
          type_name = representation.value.type_name
          dynamic "form_parameter" {
            for_each = representation.value.form_parameter
            content {
              name = form_parameter.value.name
              required = form_parameter.value.required
              type = form_parameter.value.type
              description = form_parameter.value.description
              default_value = form_parameter.value.default_value
              values = form_parameter.value.values
              schema_id = form_parameter.value.schema_id
              type_name = form_parameter.value.type_name
              dynamic "example" {
                for_each = form_parameter.value.example
                content {
                  name = example.value.name
                  summary = example.value.summary
                  description = example.value.description
                  value = example.value.value
                  external_value = example.value.external_value
                }
              }
            }
          }
          dynamic "example" {
            for_each = representation.value.example
            content {
              name = example.value.name
              summary = example.value.summary
              description = example.value.description
              value = example.value.value
              external_value = example.value.external_value
            }
          }
        }
      }
    }
  }

  dynamic "response" {
    for_each = var.response
    content {
      status_code = response.value.status_code
      description = response.value.description
      dynamic "header" {
        for_each = response.value.header
        content {
          name = header.value.name
          required = header.value.required
          type = header.value.type
          description = header.value.description
          default_value = header.value.default_value
          values = header.value.values
          schema_id = header.value.schema_id
          type_name = header.value.type_name
          dynamic "example" {
            for_each = header.value.example
            content {
              name = example.value.name
              summary = example.value.summary
              description = example.value.description
              value = example.value.value
              external_value = example.value.external_value
            }
          }
        }
      }

      dynamic "representation" {
        for_each = response.value.representation
        content {
          content_type = representation.value.content_type
          schema_id = representation.value.schema_id
          type_name = representation.value.type_name
          dynamic "form_parameter" {
            for_each = representation.value.form_parameter
            content {
              name = form_parameter.value.name
              required = form_parameter.value.required
              type = form_parameter.value.type
              description = form_parameter.value.description
              default_value = form_parameter.value.default_value
              values = form_parameter.value.values
              schema_id = form_parameter.value.schema_id
              type_name = form_parameter.value.type_name
              dynamic "example" {
                for_each = form_parameter.value.example
                content {
                  name = example.value.name
                  summary = example.value.summary
                  description = example.value.description
                  value = example.value.value
                  external_value = example.value.external_value
                }
              }
            }
          }
          dynamic "example" {
            for_each = representation.value.example
            content {
              name = example.value.name
              summary = example.value.summary
              description = example.value.description
              value = example.value.value
              external_value = example.value.external_value
            }
          }
        }
      }
    }
  }

  dynamic "template_parameter" {
    for_each = var.template_parameter
    content {
      name = template_parameter.value.name
      required = template_parameter.value.required
      type = template_parameter.value.type
      description = template_parameter.value.description
      default_value = template_parameter.value.default_value
      values = template_parameter.value.values
      schema_id = template_parameter.value.schema_id
      type_name = template_parameter.value.type_name
      dynamic "example" {
        for_each = template_parameter.value.example
        content {
          name = example.value.name
          summary = example.value.summary
          description = example.value.description
          value = example.value.value
          external_value = example.value.external_value
        }
      }
    }
  }
}