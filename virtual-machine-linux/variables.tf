variable "name" {
    type = string
}
variable "admin_username" {
    type = string
}
variable "subnet_id" {
    type = string
}
variable "private_ip_address_allocation" {
    type    = string
    default = "Dynamic"
}
variable "network_security_group_id" {
    type = string
    default = null
}
variable "resource_group_name" {
    type = string
}
variable "location" {
    type = string
}
variable "license_type" {
    type = string
    default = null
}
variable "size" {
    type = string
}
variable "os_disk" {
    type = object({
        caching = optional(string, "ReadWrite")
        storage_account_type = optional(string, "Standard_LRS")
        diff_disk_settings   = optional(list(object({
            option = string
            placement = optional(string)
        })))
        disk_encryption_set_id = optional(string)
        disk_size_gb = optional(number)
        name = optional(string)
        secure_vm_disk_encryption_set_id = optional(string)
        security_encryption_type = optional(string)
        write_accelerator_enabled = optional(string)
    })
    default = {
        caching = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }
}
variable "additional_capabilities" {
    type = object({
        ultra_ssd_enabled = optional(bool)
    })
    default = null
}
variable "plan" {
    type = object({
        name = string
        product = string
        publisher = string
    })
    default = null
}
variable "admin_ssh_key" {
    type = any
    default = null
}
variable "allow_extension_operations" {
    type = bool
    default = null
}
variable "availability_set_id" {
    type = string
    default = null
}
variable "bypass_platform_safety_checks_on_user_schedule_enabled" {
    type = bool
    default = null
}
variable "boot_diagnostics" {
    type = object({
        storage_account_uri = optional(string)
    })
    default = null
}
variable "capacity_reservation_group_id" {
    type = string
    default = null
}
variable "computer_name" {
    type = string
    default = null
}
variable "custom_data" {
    type = string
    default = null
}
variable "dedicated_host_id" {
    type = string
    default = null
}
variable "dedicated_host_group_id" {
    type = string
    default = null
}
variable "edge_zone" {
    type = string
    default = null
}
variable "encryption_at_host_enabled" {
    type = bool
    default = null
}
variable "eviction_policy" {
    type = string
    default = null
}
variable "extensions_time_budget" {
    type = string
    default = null
}
variable "gallery_application" {
    type = object({
        version_id = string
        configuration_blob_uri = optional(string)
        order = optional(bool)
        tag = optional(string)
    })
    default = null
}
variable "identity" {
    type = object({
        type = string
        identity_ids = optional(list(string))
    })
    default = null
}
variable "patch_assessment_mode" {
    type = string
    default = null
}
variable "patch_mode" {
    type = string
    default = null
}
variable "max_bid_price" {
    type = number
    default = null
}
variable "platform_fault_domain" {
    type = number
    default = null
}
variable "priority" {
    type = string
    default = null
}
variable "provision_vm_agent" {
    type = bool
    default = null
}
variable "proximity_placement_group_id" {
    type = bool
    default = null
}
variable "reboot_setting" {
    type = string
    default = null
}
variable "secret" {
    type = list(object({
        certificate = object({
            url = string
        })
        key_vault_id = string
    }))
    default = []
}
variable "secure_boot_enabled" {
    type = bool
    default = null
}
variable "source_image_id" {
    type = bool
    default = null
}
variable "source_image_reference" {
    type = object({
        publisher = string
        offer = string
        sku = string
        version = string
    })
    default = null
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "termination_notification" {
    type = object({
        enabled = bool
        timeout = optional(string)
    })
    default = null
}
variable "user_data" {
    type = string
    default = null
}
variable "nics" {
    type = any
    default = null
}
variable "vtpm_enabled" {
    type = bool
    default = null
}
variable "virtual_machine_scale_set_id" {
    type = string
    default = null
}
variable "zone" {
    type = string
    default = null
}