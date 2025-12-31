# General
variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
}

variable "tags" {
  description = "(Optional) Specifies the tags of the Front Door profile"
  type        = map(string)
  default     = {}
}

# Front Door profile
variable "profile_name" {
  description = "name of the front door profile"
  type        = string
}

variable "sku_name" {
  description = "SKU name of the Front Door profile. Possible values are 'Standard_AzureFrontDoor' and 'Premium_AzureFrontDoor'"
  type        = string
}

# Front Door endpoints (multiple support)
variable "endpoints" {
  description = "List of Front Door endpoints to create"
  type = list(object({
    name = string
  }))
}

# Front Door origin groups (multiple support)
variable "origin_groups" {
  description = "List of Front Door origin groups to create"
  type = list(object({
    name                               = string
    session_affinity_enabled           = bool
    additional_latency_in_milliseconds = number
    sample_size                        = number
    successful_samples_required        = number
  }))
}

# Front Door origins (multiple support)
variable "origins" {
  description = "List of Front Door origins to create"
  type = list(object({
    name                           = string
    origin_group_name              = string
    host_name                      = string
    certificate_name_check_enabled = bool
    origin_host_header             = string
    priority                       = number
    weight                         = number
  }))
}