terraform {
  backend "azurerm" {}
}

locals {
  location      = var.location
  common_tags   = merge(var.tags, {
    Environment   = "test"
    Project       = "azure-infrastructure-tf"
    ManagedBy     = "tomer"
  })
}

module "network" {
  source = "../../terraform-modules/network-module"

  resource_groups   = var.resource_groups  
  vnets             = var.vnets
  subnets           = var.subnets
  peerings          = var.peerings
  common_tags       = local.common_tags  
  vnet_ids          = {}  # This will be populated by the module outputs
}