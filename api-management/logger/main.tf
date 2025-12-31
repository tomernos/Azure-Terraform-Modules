resource "azurerm_api_management_logger" "this" {
  name = var.name
  resource_group_name = var.resource_group_name
  api_management_name = var.api_management_name

  dynamic "application_insights" {
    for_each = var.application_insights
    content {
      instrumentation_key = application_insights.value.instrumentation_key
    }
  }

  buffered = var.buffered
  description = var.description

  dynamic "eventhub" {
    for_each = var.eventhub
    content {
      name = eventhub.value.name
      connection_string = eventhub.value.connection_string
      user_assigned_identity_client_id = eventhub.value.user_assigned_identity_client_id
      endpoint_uri = eventhub.value.endpoint_uri
    }
  }

  resource_id = var.resource_id
}