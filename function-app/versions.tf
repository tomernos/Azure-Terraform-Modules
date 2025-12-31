terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.57.0"
    }
    azapi = {
      source = "Azure/azapi"
      version = ">= 0.1.0"
    }
  }
}

