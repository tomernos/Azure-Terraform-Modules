data "azurerm_application_insights" "this" {
  name                = var.create ? azurerm_application_insights.this["application_insights"].name : var.name
  resource_group_name = var.resource_group_name
}
resource "azurerm_application_insights" "this" {
  for_each            = var.create ? toset(["application_insights"]) : toset([])
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  application_type    = var.application_type
  workspace_id        = var.workspace_id 
  retention_in_days   = var.retention_in_days
  daily_data_cap_in_gb = var.daily_data_cap_in_gb
  sampling_percentage = var.sampling_percentage
  local_authentication_disabled = var.local_authentication_disabled
  internet_ingestion_enabled = var.internet_ingestion_enabled
  internet_query_enabled = var.internet_query_enabled
  force_customer_storage_for_profiler = var.force_customer_storage_for_profiler
  tags                = var.tags
}

