# This file provides an overview of the compute module, including its purpose, usage, and input/output variables.

# Compute Module for Azure Terraform Project

## Overview
The compute module is responsible for creating and managing Linux virtual machines (VMs) in Microsoft Azure. It provisions the necessary resources, including a network interface (NIC) and a public IP address, to ensure that the VM is accessible.

## Usage
To use this module, include it in your Terraform configuration and provide the required input variables. The module can be called from any environment configuration file (e.g., `dev/main.tf`, `staging/main.tf`, `prod/main.tf`).

### Example
```hcl
module "compute" {
  source              = "../modules/compute"
  vm_size            = var.vm_size
  image              = var.image
  admin_username     = var.admin_username
  ssh_key            = var.ssh_key
  nic_subnet_id      = module.network.subnet_id
}
```

## Input Variables
- `vm_size`: The size of the virtual machine (e.g., "Standard_DS1_v2").
- `image`: The image to use for the VM (e.g., "UbuntuLTS").
- `admin_username`: The username for the VM administrator.
- `ssh_key`: The SSH public key for accessing the VM.
- `nic_subnet_id`: The subnet ID where the NIC will be created.

## Outputs
- `vm_id`: The ID of the created virtual machine.
- `public_ip`: The public IP address assigned to the VM.

## Notes
Ensure that the necessary permissions and configurations are in place in your Azure account to create and manage the resources defined in this module.