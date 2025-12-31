resource "azurerm_application_gateway" "this" {

  name                              = var.name
  resource_group_name               = var.resource_group_name
  location                          = var.location
  tags                              = var.tags
  zones                             = var.zones
  enable_http2                      = var.enable_http2
  force_firewall_policy_association = var.force_firewall_policy_association
  firewall_policy_id                = var.firewall_policy_id
  dynamic "rewrite_rule_set" {
    for_each = var.rewrite_rule_set
    content {
      name = rewrite_rule_set.key
      dynamic "rewrite_rule" {
        for_each = lookup(rewrite_rule_set.value, "rewrite_rule", {})
        content {
          name = rewrite_rule.key
          rule_sequence = rewrite_rule.value.rule_sequence
          dynamic "condition" {
            for_each = lookup(rewrite_rule.value, "condition", {})
            content {
              variable = condition.value.variable
              pattern = lookup(condition.value, "pattern","")
              ignore_case = lookup(condition.value, "ignore_case",null)
              negate = lookup(condition.value, "negate",null)
            }
          }
          dynamic "request_header_configuration" {
            for_each = lookup(rewrite_rule.value, "request_header_configuration", {})
            content {
              header_name = request_header_configuration.value.header_name
              header_value = request_header_configuration.value.header_value
            }
          }
          dynamic "response_header_configuration" {
            for_each = lookup(rewrite_rule.value, "response_header_configuration", {})
            content {
              header_name = response_header_configuration.value.header_name
              header_value = response_header_configuration.value.header_value
            }
          }
        }
      }
    }
  }
  dynamic "backend_address_pool" {
    for_each = var.backend_address_pool
    content {
      name         = backend_address_pool.key
      fqdns        = lookup(backend_address_pool.value, "fqdns", null)
      ip_addresses = lookup(backend_address_pool.value, "ip_addresses", null)
    }
  }

  dynamic "backend_http_settings" {
    for_each = var.backend_http_settings
    content {
      name                                = backend_http_settings.key
      cookie_based_affinity               = backend_http_settings.value.cookie_based_affinity
      port                                = backend_http_settings.value.port
      protocol                            = backend_http_settings.value.protocol
      affinity_cookie_name                = lookup(backend_http_settings.value, "affinity_cookie_name", null)
      path                                = lookup(backend_http_settings.value, "path", null)
      probe_name                          = lookup(backend_http_settings.value, "probe_name", null)
      request_timeout                     = lookup(backend_http_settings.value, "request_timeout", null)
      host_name                           = lookup(backend_http_settings.value, "host_name", null)
      pick_host_name_from_backend_address = lookup(backend_http_settings.value, "pick_host_name_from_backend_address", null)
      trusted_root_certificate_names      = lookup(backend_http_settings.value, "trusted_root_certificate_names", [])
    }
  }

  dynamic "frontend_ip_configuration" {
    for_each = var.frontend_ip_configuration
    content {
      name                            = frontend_ip_configuration.key
      subnet_id                       = frontend_ip_configuration.value.type == "Public" ? null : var.subnet_id
      private_ip_address              = lookup(frontend_ip_configuration.value, "private_ip_address", null)
      public_ip_address_id            = frontend_ip_configuration.value.type == "Public" ? var.public_ip_address_id : null
      private_ip_address_allocation   = lookup(frontend_ip_configuration.value, "private_ip_address_allocation", null)
      private_link_configuration_name = lookup(frontend_ip_configuration.value, "private_link_configuration_name", null)
    }
  }

  dynamic "frontend_port" {
    for_each = var.frontend_port
    content {
      name = frontend_port.key
      port = frontend_port.value.port
    }
  }
  dynamic "autoscale_configuration" {
    for_each = var.autoscale_configuration != null ? toset(["autoscale_configuration"]) : toset([])
    content {
      min_capacity = var.autoscale_configuration.min_capacity
      max_capacity  = lookup(var.autoscale_configuration, "max_capacity", null)
    }
  }

  dynamic "gateway_ip_configuration" {
    for_each = var.gateway_ip_configuration
    content {
      name      = gateway_ip_configuration.key
      subnet_id = lookup(var.gateway_ip_configuration, "subnet_id", var.subnet_id)
    }
  }

  dynamic "http_listener" {
    for_each = var.http_listener
    content {
      name                           = http_listener.key
      frontend_ip_configuration_name = http_listener.value.frontend_ip_configuration_name
      frontend_port_name             = http_listener.value.frontend_port_name
      protocol                       = http_listener.value.protocol
      ssl_certificate_name           = lookup(http_listener.value, "ssl_certificate_name", null)
      host_name                      = lookup(http_listener.value, "host_name", null)
      host_names                     = lookup(http_listener.value, "host_names", null)
      require_sni                    = lookup(http_listener.value, "require_sni", null)
      firewall_policy_id             = lookup(http_listener.value, "firewall_policy_id", null)
    }
  }

  dynamic "request_routing_rule" {
    for_each = var.request_routing_rule
    content {
      name                        = request_routing_rule.key
      rule_type                   = request_routing_rule.value.rule_type
      http_listener_name          = request_routing_rule.value.http_listener_name
      backend_address_pool_name   = lookup(request_routing_rule.value, "backend_address_pool_name", null)
      backend_http_settings_name  = lookup(request_routing_rule.value, "backend_http_settings_name", null)
      url_path_map_name           = lookup(request_routing_rule.value, "url_path_map_name", null)
      redirect_configuration_name = lookup(request_routing_rule.value, "redirect_configuration_name", null)
      rewrite_rule_set_name       = lookup(request_routing_rule.value, "rewrite_rule_set_name", null)
      priority                    = lookup(request_routing_rule.value, "priority", null)
    }
  }
  dynamic "url_path_map" {
    for_each = var.url_path_map
    content {
      name = url_path_map.key
      default_backend_address_pool_name = lookup(url_path_map.value, "default_backend_address_pool_name", null)
      default_rewrite_rule_set_name = lookup(url_path_map.value, "default_rewrite_rule_set_name", null)
      default_backend_http_settings_name = lookup(url_path_map.value, "default_backend_http_settings_name", null)
      default_redirect_configuration_name = lookup(url_path_map.value, "default_redirect_configuration_name", null)
      dynamic "path_rule" {
        for_each = url_path_map.value.path_rule 
        content {
          name = path_rule.key
          paths = path_rule.value.paths 
          backend_address_pool_name = lookup(path_rule.value, "backend_address_pool_name", null)
          backend_http_settings_name = lookup(path_rule.value, "backend_http_settings_name", null)
          redirect_configuration_name = lookup(path_rule.value, "redirect_configuration_name", null)
          rewrite_rule_set_name = lookup(path_rule.value, "rewrite_rule_set_name", null)
          firewall_policy_id = lookup(path_rule.value, "firewall_policy_id", null)

        }
      }
    }
  }

  sku {
    name     = var.sku.name
    capacity = lookup(var.sku,"capacity", null)
    tier     = var.sku.tier
  }

  dynamic "ssl_certificate" {
    for_each = var.ssl_certificate
    content {
      name = ssl_certificate.key
      data = lookup(ssl_certificate.value, "data", null)
      password = lookup(ssl_certificate.value, "secret", null)
      key_vault_secret_id = lookup(ssl_certificate.value, "key_vault_secret_id", null)
    }
  }

  dynamic "identity" {
    for_each = var.identity != null ? toset(["identity"]) : toset([])
    content {
      type = "UserAssigned"
      identity_ids = lookup(var.identity, "identity_ids", var.identity_ids)
    }
  }

  dynamic "waf_configuration" {
    for_each = var.waf_configuration
    content {
      enabled = waf_configuration.value.enabled
      firewall_mode = waf_configuration.value.firewall_mode
      rule_set_type = waf_configuration.value.rule_set_type
      rule_set_version = waf_configuration.value.rule_set_version
      file_upload_limit_mb = lookup(waf_configuration.value, "file_upload_limit_mb", 100)
      request_body_check = lookup(waf_configuration.value, "request_body_check", true)
      max_request_body_size_kb = lookup(waf_configuration.value, "max_request_body_size_kb", 128)
    }
  }

  dynamic "probe" {
    for_each = var.probe
    content {
      name                = probe.key
      interval            = probe.value.interval
      protocol            = probe.value.protocol
      path                = probe.value.path
      timeout             = probe.value.timeout
      unhealthy_threshold = probe.value.unhealthy_threshold
      host                = lookup(probe.value, "host", null)
      port                = lookup(probe.value, "port", null)
      pick_host_name_from_backend_http_settings = lookup(probe.value, "pick_host_name_from_backend_http_settings", false)
      minimum_servers     = lookup(probe.value, "minimum_servers", 0)
    }
  }

  dynamic "ssl_policy" {
    for_each = var.ssl_policy
    content {
      policy_name = ssl_policy.key
      disabled_protocols  = lookup(ssl_policy.value, "disabled_protocols", null)
      policy_type = lookup(ssl_policy.value, "policy_type", null)
      cipher_suites = lookup(ssl_policy.value, "cipher_suites", null )
      min_protocol_version = lookup(ssl_policy.value, "min_protocol_version", null)
    }
  }
}