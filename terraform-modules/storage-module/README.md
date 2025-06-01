# Storage Module

This module is responsible for creating and managing Azure Storage resources. It is designed to be reusable and configurable through input variables.

## Usage

To use this module, include it in your Terraform configuration as follows:

```hcl
module "storage" {
  source              = "../modules/storage"
  storage_account_name = var.storage_account_name
  location           = var.location
  resource_group_name = var.resource_group_name
  account_tier       = var.account_tier
  account_replication = var.account_replication
}
```

## Inputs

| Name                     | Description                                      | Type   | Default | Required |
|--------------------------|--------------------------------------------------|--------|---------|:--------:|
| storage_account_name     | The name of the storage account.                 | string | n/a     |   yes    |
| location                 | The Azure region where the storage account will be created. | string | n/a     |   yes    |
| resource_group_name      | The name of the resource group.                  | string | n/a     |   yes    |
| account_tier             | The performance tier of the storage account (e.g., Standard, Premium). | string | "Standard" | no     |
| account_replication      | The replication strategy for the storage account (e.g., LRS, GRS). | string | "LRS"   | no     |

## Outputs

| Name                     | Description                                      |
|--------------------------|--------------------------------------------------|
| storage_account_id       | The ID of the created storage account.           |
| primary_blob_endpoint    | The primary blob service endpoint.               |
| primary_queue_endpoint    | The primary queue service endpoint.               |
| primary_table_endpoint   | The primary table service endpoint.              |

## Example

```hcl
module "storage" {
  source              = "../modules/storage"
  storage_account_name = "mystorageaccount"
  location           = "East US"
  resource_group_name = "myResourceGroup"
  account_tier       = "Standard"
  account_replication = "LRS"
}
```

## Notes

- Ensure that the storage account name is globally unique.
- Adjust the replication strategy based on your availability and durability requirements.