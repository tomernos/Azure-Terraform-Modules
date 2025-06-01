variable "location" {
  description = "Default Azure region"
  type        = string
  default     = "northeurope"
}

variable "Environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
}

variable "resource_groups" {
  description = "Resource groups definitions"
  type = map(object({
    location = string
    tags     = optional(map(string), {})
  }))
}

variable "vnets" {
  description = "Virtual networks configuration"
  type = map(object({
    location        = string
    resource_group  = string
    address_space   = list(string)
    tags            = optional(map(string), {})
  }))
}

# Fixed: Updated to match the module's expected structure
variable "subnets" {
  description = "Subnets configuration"
  type = map(object({
    resource_group  = string
    virtual_network = string
    cidr            = list(string)
    tags            = optional(map(string), {})
  }))
}

variable "peerings" {
  description = "Peering connections"
  default     = {}
  type = map(object({
    resource_group                = string
    source_vnet                   = string
    remote_vnet_key               = string
    allow_vnet_access             = optional(bool, true)
    allow_forwarded               = optional(bool, true)
    allow_gateway_transit         = optional(bool, false)
    tags                          = optional(map(string), {})
  }))
}

variable "route_tables" {
  description = "Map of route tables"
  type = map(object({
    location       = string
    resource_group = string
    tags           = map(string)
  }))
  default = {}
}

variable "routes" {
  description = "Map of individual routes"
  type = map(object({
    resource_group        = string
    route_table_key       = string
    address_prefix        = string
    next_hop_type         = string
    next_hop_in_ip_address = optional(string)
  }))
  default = {}
}

variable "vms" {
  description = "Map of VM configurations"
  type = map(object({
    vm_size                         = string
    subnet_name                     = string
    resource_group                  = string
    os_type                         = string
    create_public_ip                = optional(bool, false)
    disable_password_authentication = optional(bool, true)
    admin_username               = optional(string, "azureuser")
    admin_password               = optional(string)
    ssh_public_key                  = optional(string)
    os_disk_caching                 = optional(string, "ReadWrite")
    os_disk_type                    = optional(string, "Standard_LRS")
    image = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
  }))
  default = {}
}

variable "tags" {
  description = "Global tags"
  type        = map(string)
  default     = {}
}