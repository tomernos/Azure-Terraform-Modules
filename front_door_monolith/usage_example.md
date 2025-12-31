# Front Door Module Usage Example

## Simple Web Application Example

```hcl
# main.tf

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "example" {
  name     = "rg-frontdoor-example"
  location = "East US"
}

# Front Door with multiple endpoints and origins
module "frontdoor" {
  source = "./front_door"

  profile_name        = "fd-webapp-prod"
  resource_group_name = azurerm_resource_group.example.name
  sku_name           = "Standard_AzureFrontDoor"

  # Create endpoints for different parts of your application
  endpoints = [
    {
      name = "web-endpoint"
    },
    {
      name = "api-endpoint"
    }
  ]

  # Create origin groups for different backend pools
  origin_groups = [
    {
      name                               = "web-servers"
      session_affinity_enabled           = false
      additional_latency_in_milliseconds = 50
      sample_size                        = 4
      successful_samples_required        = 3
    },
    {
      name                               = "api-servers"
      session_affinity_enabled           = false
      additional_latency_in_milliseconds = 30
      sample_size                        = 2
      successful_samples_required        = 2
    }
  ]

  # Define your backend origins
  origins = [
    # Web application origins
    {
      name                           = "web-primary"
      origin_group_name              = "web-servers"
      host_name                      = "webapp.mycompany.com"
      certificate_name_check_enabled = true
      origin_host_header             = "webapp.mycompany.com"
      priority                       = 1
      weight                         = 1000
    },
    {
      name                           = "web-backup"
      origin_group_name              = "web-servers"
      host_name                      = "webapp-backup.mycompany.com"
      certificate_name_check_enabled = true
      origin_host_header             = "webapp-backup.mycompany.com"
      priority                       = 2
      weight                         = 500
    },
    # API origins
    {
      name                           = "api-primary"
      origin_group_name              = "api-servers"
      host_name                      = "api.mycompany.com"
      certificate_name_check_enabled = true
      origin_host_header             = "api.mycompany.com"
      priority                       = 1
      weight                         = 1000
    }
  ]

  tags = {
    Environment = "production"
    Project     = "webapp"
    Owner       = "devops-team"
  }
}

# Outputs to see what was created
output "frontdoor_endpoints" {
  description = "Front Door endpoint hostnames"
  value       = module.frontdoor.frontdoor_endpoint_hostnames
}

output "frontdoor_profile_name" {
  description = "Front Door profile name"
  value       = module.frontdoor.frontdoor_profile_name
}
```

## Multi-Region High Availability Example

```hcl
module "global_frontdoor" {
  source = "./front_door"

  profile_name        = "fd-global-app"
  resource_group_name = azurerm_resource_group.example.name
  sku_name           = "Premium_AzureFrontDoor"  # Premium for better features

  endpoints = [
    {
      name = "global-endpoint"
    }
  ]

  origin_groups = [
    {
      name                               = "global-backends"
      session_affinity_enabled           = false
      additional_latency_in_milliseconds = 30
      sample_size                        = 4
      successful_samples_required        = 3
    }
  ]

  origins = [
    # Primary region - US East
    {
      name                           = "us-east-app"
      origin_group_name              = "global-backends"
      host_name                      = "app-useast.mycompany.com"
      certificate_name_check_enabled = true
      origin_host_header             = "app-useast.mycompany.com"
      priority                       = 1
      weight                         = 1000
    },
    # Secondary region - Europe West
    {
      name                           = "eu-west-app"
      origin_group_name              = "global-backends"
      host_name                      = "app-euwest.mycompany.com"
      certificate_name_check_enabled = true
      origin_host_header             = "app-euwest.mycompany.com"
      priority                       = 2
      weight                         = 1000
    },
    # Tertiary region - Asia Southeast
    {
      name                           = "asia-app"
      origin_group_name              = "global-backends"
      host_name                      = "app-asia.mycompany.com"
      certificate_name_check_enabled = true
      origin_host_header             = "app-asia.mycompany.com"
      priority                       = 3
      weight                         = 1000
    }
  ]

  tags = {
    Environment = "production"
    Scope       = "global"
    Tier        = "premium"
  }
}
```

## Azure App Service Example

```hcl
# If you're using Azure App Services as your backend
resource "azurerm_service_plan" "example" {
  name                = "asp-webapp"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_linux_web_app" "primary" {
  name                = "webapp-primary"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  service_plan_id     = azurerm_service_plan.example.id

  site_config {}
}

resource "azurerm_linux_web_app" "secondary" {
  name                = "webapp-secondary"
  resource_group_name = azurerm_resource_group.example.name
  location            = "West Europe"
  service_plan_id     = azurerm_service_plan.example.id

  site_config {}
}

module "frontdoor_appservice" {
  source = "./front_door"

  profile_name        = "fd-appservice"
  resource_group_name = azurerm_resource_group.example.name
  sku_name           = "Standard_AzureFrontDoor"

  endpoints = [
    {
      name = "app-endpoint"
    }
  ]

  origin_groups = [
    {
      name                               = "appservice-group"
      session_affinity_enabled           = false
      additional_latency_in_milliseconds = 50
      sample_size                        = 4
      successful_samples_required        = 3
    }
  ]

  origins = [
    {
      name                           = "primary-app"
      origin_group_name              = "appservice-group"
      host_name                      = azurerm_linux_web_app.primary.default_hostname
      certificate_name_check_enabled = true
      origin_host_header             = azurerm_linux_web_app.primary.default_hostname
      priority                       = 1
      weight                         = 1000
    },
    {
      name                           = "secondary-app"
      origin_group_name              = "appservice-group"
      host_name                      = azurerm_linux_web_app.secondary.default_hostname
      certificate_name_check_enabled = true
      origin_host_header             = azurerm_linux_web_app.secondary.default_hostname
      priority                       = 2
      weight                         = 500
    }
  ]

  tags = {
    Environment = "production"
    Backend     = "app-service"
  }
}
```

## Expected Terraform Commands

1. **Initialize:**
   ```bash
   terraform init
   ```

2. **Plan:**
   ```bash
   terraform plan
   ```

3. **Apply:**
   ```bash
   terraform apply
   ```

4. **View outputs:**
   ```bash
   terraform output
   ```

## Expected Outputs

After deployment, you'll see outputs like:

```
frontdoor_endpoints = [
  "web-endpoint-abc123.z01.azurefd.net",
  "api-endpoint-abc123.z01.azurefd.net"
]
frontdoor_profile_name = "fd-webapp-prod"
```

You can then use these hostnames to route traffic through your Front Door!

## Key Configuration Tips

1. **Priority**: Lower numbers = higher priority (1 is highest)
2. **Weight**: Higher numbers get more traffic when same priority
3. **Session Affinity**: Enable only if your app requires sticky sessions
4. **Health Probes**: Adjust sample_size and successful_samples_required based on your reliability needs

This clean configuration gives you enterprise-grade global load balancing with automatic failover! 🚀
