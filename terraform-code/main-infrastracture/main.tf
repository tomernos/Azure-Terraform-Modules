terraform {
  backend "azurerm" {}
}

locals {
  location      = var.location
  common_tags   = merge(var.tags, {
    Environment   = "DEV"
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
  route_tables      = var.route_tables
  routes            = var.routes
  common_tags       = local.common_tags  
}

module "compute" {
  source              = "../../terraform-modules/compute-module"
  location            = module.network.resource_group_location[var.vms.resource_group_name]
  subnet_ids          = module.network.subnet_ids
  vms                 = var.vms
  tags                = local.common_tags
}