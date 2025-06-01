variable "resource_groups" {
  description = "Map of resource groups to create"
  type = map(object({
    location = string
    tags     = optional(map(string), {})
  }))
  default     = {}
}

variable "vnets" {
  description = "Map of virtual networks"
  type        = map(object({
    location        = string
    resource_group  = string
    address_space   = list(string)
    tags            = optional(map(string), {})
  }))
  default     = {}
}

variable "subnets" {
  description = "Map of subnets"
  type        = map(object({
    resource_group  = string
    virtual_network = string
    cidr            = list(string)
    tags            = map(string)
  }))
  default     = {}
}

variable "peerings" {
  description = "Map of VNET peerings"
  type        = map(object({
    resource_group   = string
    source_vnet      = string
    remote_vnet_key  = string
    allow_vnet_access = optional(bool, true)
    allow_forwarded   = optional(bool, true)
    tags             = map(string)
  }))
  default     = {}
}

variable "common_tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "vnet_ids" {
  description = "Map of VNET IDs"
  type        = map(string)
  default     = {}
}