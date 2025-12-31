resource "azurerm_api_management_api" "this" {
  for_each = var.create ? toset(["api"]) : toset([])
  name = var.name
  api_management_name = var.api_management_name
  resource_group_name = var.resource_group_name
  revision = var.revision
  api_type = var.api_type
  display_name = var.display_name
  path = var.path
  protocols = var.protocols

  dynamic "contact" {
    for_each = var.contact
    content {
      email = contact.value.email
      name = contact.value.name
      url = contact.value.url
    }
  }

  description = var.description

  dynamic "import" {
    for_each = var.import
    content {
      content_format = import.value.content_format
      content_value = import.value.content_value
      dynamic "wsdl_selector" {
        for_each = import.value.wsdl_selector
        content {
          service_name = wsdl_selector.value.service_name
          endpoint_name = wsdl_selector.value.endpoint_name
        }
      }
    }
  }

  dynamic "license" {
    for_each = var.license
    content {
      name = license.value.name
      url = license.value.url
    }
  }

  dynamic "oauth2_authorization" {
    for_each = var.oauth2_authorization
    content {
      authorization_server_name = oauth2_authorization.value.authorization_server_name
      scope = oauth2_authorization.value.scope
    }
  }

  dynamic "openid_authentication" {
    for_each = var.openid_authentication
    content {
      openid_provider_name = openid_authentication.value.openid_provider_name
      bearer_token_sending_methods = openid_authentication.value.bearer_token_sending_methods
    }
  }

  service_url = var.service_url

  dynamic "subscription_key_parameter_names" {
    for_each = var.subscription_key_parameter_names
    content {
      header = subscription_key_parameter_names.value.header
      query = subscription_key_parameter_names.value.query
    }
  }

  subscription_required = var.subscription_required
  terms_of_service_url = var.terms_of_service_url
  version = var.api_version
  version_set_id = var.version_set_id
  revision_description = var.revision_description
  version_description = var.version_description
  source_api_id = var.source_api_id
}

data "azurerm_api_management_api" "this" {
  name = var.create ? azurerm_api_management_api.this["api"].name : var.name
  api_management_name = var.api_management_name
  resource_group_name = var.resource_group_name
  revision = var.revision
}