variable "location" {
  description = "Default Azure region"
  type        = string
  default     = "northeurope"
}

variable "environment" {
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
  type = map(object({
    resource_group      = string
    source_vnet         = string
    remote_vnet_key     = string
    allow_vnet_access   = optional(bool, true)
    allow_forwarded     = optional(bool, true)
    tags                = optional(map(string), {})
  }))
}

variable "tags" {
  description = "Global tags"
  type        = map(string)
  default     = {}
}