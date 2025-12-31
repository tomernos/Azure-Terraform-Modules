resource "azurerm_cdn_frontdoor_rule" "this" {
  name                = var.name
  cdn_frontdoor_rule_set_id           = var.cdn_frontdoor_rule_set_id
  order = var.order
  behavior_on_match = var.behavior_on_match
  actions {
    dynamic "url_rewrite_action"{
      for_each = lookup(var.actions,"url_rewrite_action", {})
      content {
        source_pattern = url_rewrite_action.value.source_pattern
        destination = url_rewrite_action.value.destination
        preserve_unmatched_path = lookup(url_rewrite_action.value,"preserve_unmatched_path", null)
      }
    }
    dynamic "url_redirect_action" {
      for_each = lookup(var.actions,"url_redirect_action", {})
      content {
        redirect_type = url_redirect_action.value.redirect_type
        destination_hostname = url_redirect_action.value.destination_hostname
        redirect_protocol = lookup(url_redirect_action.value,"redirect_protocol", null)
        destination_path = lookup(url_redirect_action.value,"destination_path", null)
        query_string = lookup(url_redirect_action.value,"query_string", null)
        destination_fragment = lookup(url_redirect_action.value,"destination_fragment", null)
      }
    }
    dynamic "route_configuration_override_action" {
      for_each = lookup(var.actions,"route_configuration_override_action", {})
      content {
        cache_duration = lookup(route_configuration_override_action.value,"cache_duration", null)
        cdn_frontdoor_origin_group_id = lookup(route_configuration_override_action.value,"cdn_frontdoor_origin_group_id", null)
        forwarding_protocol = lookup(route_configuration_override_action.value,"forwarding_protocol", null)
        query_string_caching_behavior = lookup(route_configuration_override_action.value,"query_string_caching_behavior", null)
        query_string_parameters = lookup(route_configuration_override_action.value,"query_string_parameters", null)
        compression_enabled = lookup(route_configuration_override_action.value,"compression_enabled", null)
        cache_behavior = lookup(route_configuration_override_action.value,"cache_behavior", null)
      }
    }
    dynamic "request_header_action" {
      for_each = lookup(var.actions,"request_header_action", {})
      content {
        header_action = request_header_action.value.header_action
        header_name = request_header_action.value.header_name
        value = lookup(request_header_action.value,"value", null)
      }
    }
    dynamic "response_header_action" {
      for_each = lookup(var.actions,"response_header_action", {}) 
      content {
        header_action = response_header_action.value.header_action
        header_name = response_header_action.value.header_name
        value = lookup(response_header_action.value,"value", null)
      }
    }
  }
  dynamic "conditions" {
    for_each = var.conditions != null ? toset(["conditions"]) : toset([])
    content {
      dynamic "remote_address_condition" {
        for_each = lookup(var.conditions,"remote_address_condition", {})
        content {
          operator = lookup(remote_address_condition.value, "operator", null)
          negate_condition = lookup(remote_address_condition.value, "negate_condition", null)
          match_values = lookup(remote_address_condition.value, "match_values", null)
        }
      }
      dynamic "request_method_condition" {
        for_each = lookup(var.conditions,"request_method_condition", {})
        content {
          match_values = request_method_condition.value.match_values
          operator = lookup(request_method_condition.value, "operator", null)
          negate_condition = lookup(request_method_condition.value, "negate_condition", null)
        }
      }
      dynamic "query_string_condition" {
        for_each = lookup(var.conditions,"query_string_condition", {})
        content {
          match_values = lookup(query_string_condition.value, "match_values",null)
          operator = query_string_condition.value.operator
          negate_condition = lookup(query_string_condition.value, "negate_condition", null)
          transforms = lookup(query_string_condition.value, "transforms", null)
        }
      }
      dynamic "post_args_condition" {
        for_each = lookup(var.conditions,"post_args_condition", {})
        content {
          match_values = lookup(post_args_condition.value, "match_values",null)
          operator = post_args_condition.value.operator
          post_args_name = post_args_condition.value.post_args_name
          negate_condition = lookup(post_args_condition.value, "negate_condition", null)
          transforms = lookup(post_args_condition.value, "transforms", null)
        }
      }
      dynamic "request_uri_condition" {
        for_each = lookup(var.conditions,"request_uri_condition", {})
        content {
          match_values = lookup(request_uri_condition.value, "match_values",null)
          operator = request_uri_condition.value.operator
          negate_condition = lookup(request_uri_condition.value, "negate_condition", null)
          transforms = lookup(request_uri_condition.value, "transforms", null)
        }
      }
      dynamic "request_header_condition" {
        for_each = lookup(var.conditions,"request_header_condition", {})
        content {
          match_values = lookup(request_header_condition.value, "match_values",null)
          operator = request_header_condition.value.operator
          header_name = request_header_condition.value.header_name
          negate_condition = lookup(request_header_condition.value, "negate_condition", null)
          transforms = lookup(request_header_condition.value, "transforms", null)
        }
      }
      dynamic "request_body_condition" {
        for_each = lookup(var.conditions,"request_body_condition", {})
        content {
          match_values = request_body_condition.value.match_values
          operator = request_body_condition.value.operator
          negate_condition = lookup(request_body_condition.value, "negate_condition", null)
          transforms = lookup(request_body_condition.value, "transforms", null)
        }
      }
      dynamic "request_scheme_condition" {
        for_each = lookup(var.conditions,"request_scheme_condition", {})
        content {
          operator = lookup(request_scheme_condition.value, "operator", null)
          negate_condition = lookup(request_scheme_condition.value, "negate_condition", null)
          match_values = lookup(request_scheme_condition.value, "match_values", null)
        }
      }
      dynamic "url_path_condition" {
        for_each = lookup(var.conditions,"url_path_condition", {})
        content {
          operator = url_path_condition.value.operator
          negate_condition = lookup(url_path_condition.value, "negate_condition", null)
          match_values = lookup(url_path_condition.value, "match_values", null)
          transforms = lookup(url_path_condition.value, "transforms", null)
        }
      }
      dynamic "url_file_extension_condition" {
        for_each = lookup(var.conditions,"url_file_extension_condition", {})
        content {
          operator = url_file_extension_condition.value.operator
          negate_condition = lookup(url_file_extension_condition.value, "negate_condition", null)
          match_values = lookup(url_file_extension_condition.value, "match_values", null)
          transforms = lookup(url_file_extension_condition.value, "transforms", null)
        }
      }
      dynamic "url_filename_condition" {
        for_each = lookup(var.conditions,"url_filename_condition", {})
        content {
          operator = url_filename_condition.value.operator
          negate_condition = lookup(url_filename_condition.value, "negate_condition", null)
          match_values = lookup(url_filename_condition.value, "match_values", null)
          transforms = lookup(url_filename_condition.value, "transforms", null)
        }
      }
      dynamic "http_version_condition" {
        for_each = lookup(var.conditions,"http_version_condition", {})
        content {
          operator = lookup(http_version_condition.value, "operator", null)
          negate_condition = lookup(http_version_condition.value, "negate_condition", null)
          match_values = http_version_condition.value.match_values
        }
      }
      dynamic "cookies_condition" {
        for_each = lookup(var.conditions,"cookies_condition", {})
        content {
          operator = cookies_condition.value.operator
          cookie_name = cookies_condition.value.cookie_name
          negate_condition = lookup(cookies_condition.value, "negate_condition", null)
          match_values = lookup(cookies_condition.value, "match_values", null)
          transforms = lookup(cookies_condition.value, "transforms", null)
        }
      }
      dynamic "is_device_condition" {
        for_each = lookup(var.conditions,"is_device_condition", {})
        content {
          operator = lookup(is_device_condition.value, "operator", null)
          negate_condition = lookup(is_device_condition.value, "negate_condition", null)
          match_values = lookup(is_device_condition.value, "transforms", null)
        }
      }
      dynamic "socket_address_condition" {
        for_each = lookup(var.conditions,"socket_address_condition", {})
        content {
          operator = lookup(socket_address_condition.value, "operator", null)
          negate_condition = lookup(socket_address_condition.value, "negate_condition", null)
          match_values = lookup(socket_address_condition.value, "transforms", null)
        }
      }
      dynamic "client_port_condition" {
        for_each = lookup(var.conditions,"client_port_condition", {})
        content {
          operator = client_port_condition.value.operator
          negate_condition = lookup(client_port_condition.value, "negate_condition", null)
          match_values = lookup(client_port_condition.value, "transforms", null)
        }
      }
      dynamic "server_port_condition" {
        for_each = lookup(var.conditions,"server_port_condition", {})
        content {
          operator = server_port_condition.value.operator
          negate_condition = lookup(server_port_condition.value, "negate_condition", null)
          match_values = server_port_condition.value.transforms
        }
      }
      dynamic "host_name_condition" {
        for_each = lookup(var.conditions,"host_name_condition", {})
        content {
          operator = host_name_condition.value.operator
          negate_condition = lookup(host_name_condition.value, "negate_condition", null)
          match_values = lookup(host_name_condition.value, "match_values", null)
          transforms = lookup(host_name_condition.value, "transforms", null)
        }
      }
      dynamic "ssl_protocol_condition" {
        for_each = lookup(var.conditions,"ssl_protocol_condition", {})
        content {
          negate_condition = lookup(ssl_protocol_condition.value, "negate_condition", null)
          match_values = ssl_protocol_condition.value.match_values
          operator = lookup(ssl_protocol_condition.value, "transforms", null)
        }
      }
    }
  }
}