variable "location" {
  description = "Azure region"
  type        = string
}

variable "subnet_ids" {
  description = "Map of subnet names to their IDs"
  type        = map(string)
}

variable "vms" {
  description = "Map of VM configurations"
  type = map(object({
    vm_size                         = string
    subnet_id                       = string
    os_type                         = string # "linux" or "windows"
    resource_group_name             = string
    create_public_ip                = optional(bool, false)
    disable_password_authentication = optional(bool, true)
    admin_username                  = optional(string, "azureuser")
    admin_password                  = optional(string)
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
  description = "Resource tags"
  type        = map(string)
  default     = {}
}
