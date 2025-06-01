# Azure Terraform Project

This project is designed to provision and manage infrastructure on Microsoft Azure using Terraform. It follows a modular and scalable architecture, allowing for easy management of different environments (development, staging, production) and resources (networking, compute, storage).

## Project Structure

```
azure-terraform-project
├── modules
│   ├── network          # Module for networking resources
│   ├── compute          # Module for compute resources (VMs)
│   └── storage          # Module for storage resources
├── environments
│   ├── dev             # Development environment
│   ├── staging         # Staging environment
│   └── prod            # Production environment
├── global              # Global configurations and variables
├── .gitignore          # Git ignore file
└── README.md           # Project documentation
```

## Modules

- **Network Module**: Defines resources for creating a Virtual Network (VNet) in Azure.
- **Compute Module**: Defines resources for creating Linux Virtual Machines (VMs) in Azure.
- **Storage Module**: Defines resources for Azure storage accounts.

## Environments

- **Development**: Contains configurations and variables specific to the development environment.
- **Staging**: Contains configurations and variables specific to the staging environment.
- **Production**: Contains configurations and variables specific to the production environment.

## Setup Instructions

1. **Configure Azure Credentials**: Set up your Azure credentials to allow Terraform to manage resources in your Azure account. You can do this by using the Azure CLI or by setting environment variables.

2. **Initialize Terraform**: Navigate to the desired environment directory (e.g., `environments/dev`) and run: terraform init
 

6. **Manage State**: The project is configured to use remote state storage in Azure. Ensure that the backend configuration in each environment is correctly set up.

## Usage Guidelines

- Modify the `terraform.tfvars` files in each environment to customize the resource configurations.
- Use the modules in the `modules` directory to add or modify resources as needed.
- Follow best practices for managing Terraform state and configurations.

