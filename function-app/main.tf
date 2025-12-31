resource "azapi_resource" "serverFarm" {
  type                     = "Microsoft.Web/serverfarms@2023-12-01"
  schema_validation_enabled = false
  location                 = var.location
  name                     = var.name
  parent_id                = var.resource_group_id

  body = {
    kind = "functionapp"
    sku = {
      tier = "FlexConsumption"
      name = "FC1"
    }
    properties = {
      reserved = true
    }
  }
}


resource "azurerm_log_analytics_workspace" "logAnalyticsWorkspace" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_application_insights" "appInsights" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"
  workspace_id        = azurerm_log_analytics_workspace.logAnalyticsWorkspace.id
}

module "storage-container" {
  source = "git::https://github.com/de-id/terraform-modules.git//azure/infra/storage-container"
  storage_account_id = var.storage_account_id
  name = var.storage_container_name
  container_access_type = "private"
}

resource "azapi_resource" "functionApps" {
  type                     = "Microsoft.Web/sites@2023-12-01"
  schema_validation_enabled = false
  location                 = var.location
  name                     = var.name
  parent_id                = var.resource_group_id
  
  body = {
    kind = "functionapp,linux"
    
    identity = {
      type = "SystemAssigned"
    }
    
    properties = {
      serverFarmId = azapi_resource.serverFarm.id
      
      functionAppConfig = {
        deployment = {
          storage = {
            type = "blobContainer"
            value = var.storage_container_name
            authentication = {
              type = "SystemAssignedIdentity"
            }
          }
        }
        
        scaleAndConcurrency = {
          maximumInstanceCount = var.maximum_instance_count
          instanceMemoryMB = var.instance_memory_mb
        }
        
        runtime = {
          name = var.function_app_runtime
          version = var.function_app_runtime_version
        }
      }
      
      siteConfig = {
        appSettings = [
          {
            name = "AzureWebJobsStorage__accountName"
            value = var.storage_account_id
          },
          {
            name = "APPLICATIONINSIGHTS_CONNECTION_STRING"
            value = azurerm_application_insights.appInsights.connection_string
          }
        ]
      }
    }
  }
  
  depends_on = [ azapi_resource.serverFarm, azurerm_application_insights.appInsights ]
}

data "azurerm_linux_function_app" "fn_wrapper" {
  name                = azapi_resource.functionApps.name
  resource_group_name = var.resource_group_name
}

resource "azurerm_role_assignment" "storage_roleassignment" {
  scope                = var.storage_account_id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = data.azurerm_linux_function_app.fn_wrapper.identity.0.principal_id
}

