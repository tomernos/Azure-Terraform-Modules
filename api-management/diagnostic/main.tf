resource "azurerm_api_management_diagnostic" "this" {
  identifier = var.identifier
  api_management_name = var.api_management_name
  resource_group_name = var.resource_group_name
  api_management_logger_id = var.api_management_logger_id

  dynamic "backend_request" {
    for_each = var.backend_request
    content {
      body_bytes = backend_request.value.body_bytes
      headers_to_log = backend_request.value.headers_to_log
      dynamic "data_masking" {
        for_each = backend_request.value.data_masking
        content {
          dynamic "query_params" {
            for_each = data_masking.value.query_params
            content {
              mode = query_params.value.mode
              value = query_params.value.value
            }
          }
          dynamic "headers" {
            for_each = data_masking.value.headers
            content {
              mode = headers.value.mode
              value = headers.value.value
            }
          }
        }
      }
    }
  }

  dynamic "backend_response" {
    for_each = var.backend_response
    content {
      body_bytes = backend_response.value.body_bytes
      headers_to_log = backend_response.value.headers_to_log
      dynamic "data_masking" {
        for_each = backend_response.value.data_masking
        content {
          dynamic "query_params" {
            for_each = data_masking.value.query_params
            content {
              mode = query_params.value.mode
              value = query_params.value.value
            }
          }
          dynamic "headers" {
            for_each = data_masking.value.headers
            content {
              mode = headers.value.mode
              value = headers.value.value
            }
          }
        }
      }
    }
  }

  dynamic "frontend_request" {
    for_each = var.frontend_request
    content {
      body_bytes = frontend_request.value.body_bytes
      headers_to_log = frontend_request.value.headers_to_log
      dynamic "data_masking" {
        for_each = frontend_request.value.data_masking
        content {
          dynamic "query_params" {
            for_each = data_masking.value.query_params
            content {
              mode = query_params.value.mode
              value = query_params.value.value
            }
          }
          dynamic "headers" {
            for_each = data_masking.value.headers
            content {
              mode = headers.value.mode
              value = headers.value.value
            }
          }
        }
      }
    }
  }

  dynamic "frontend_response" {
    for_each = var.frontend_response
    content {
      body_bytes = frontend_response.value.body_bytes
      headers_to_log = frontend_response.value.headers_to_log
      dynamic "data_masking" {
        for_each = frontend_response.value.data_masking
        content {
          dynamic "query_params" {
            for_each = data_masking.value.query_params
            content {
              mode = query_params.value.mode
              value = query_params.value.value
            }
          }
          dynamic "headers" {
            for_each = data_masking.value.headers
            content {
              mode = headers.value.mode
              value = headers.value.value
            }
          }
        }
      }
    }
  }

  http_correlation_protocol = var.http_correlation_protocol
  log_client_ip = var.log_client_ip
  sampling_percentage = var.sampling_percentage
  verbosity = var.verbosity
  operation_name_format = var.operation_name_format

}