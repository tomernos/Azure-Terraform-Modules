# This file provides an overview of the network module used in the Azure Terraform project.

# Network Module

This module is responsible for creating a virtual network (VNet) in Microsoft Azure. It allows for the configuration of address spaces, subnets, and optional VNet peering.

## Usage

To use this module, include it in your Terraform configuration as follows:

```hcl
module "network" {
  source              = "../modules/network"
  address_space       = var.address_space
  subnet_cidrs       = var.subnet_cidrs
  vnet_peering        = var.vnet_peering
}
```

## Inputs

| Name            | Description                                           | Type           | Default | Required |
|-----------------|-------------------------------------------------------|----------------|---------|----------|
| address_space    | The address space for the virtual network.           | list(string)   | n/a     | yes      |
| subnet_cidrs    | List of CIDR blocks for subnets in the VNet.        | list(string)   | n/a     | yes      |
| vnet_peering     | Optional configuration for VNet peering.            | map(string)    | {}      | no       |

## Outputs

| Name            | Description                                           |
|-----------------|-------------------------------------------------------|
| vnet_id         | The ID of the created virtual network.                |
| subnet_ids      | List of IDs of the created subnets.                   |

## Example

An example of how to call this module can be found in the `environments` directory, where it is utilized in different environments (dev, staging, prod) with specific configurations.