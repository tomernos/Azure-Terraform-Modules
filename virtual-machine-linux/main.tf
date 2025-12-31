data "azurerm_ssh_public_key" "this" {
  name                = var.admin_ssh_key.name
  resource_group_name = lookup(var.admin_ssh_key, "resource_group_name", var.resource_group_name)
}
module "network-interface" {
  source                        = "../network-interface"
  for_each = var.nics != null ? var.nics :{
    "${var.name}-nic" = {
      ip_configuration = {
        "${var.name}-nic-ip" = {}
      }
    }
  }
  name                          = each.key
  subnet_id                     = var.subnet_id
  resource_group_name           = var.resource_group_name
  location                      = var.location
  ip_configuration              = each.value.ip_configuration
  # network_security_group_id     = var.network_security_group_id
  private_ip_address_allocation = var.private_ip_address_allocation
}

resource "azurerm_linux_virtual_machine" "this" {
  admin_username                = var.admin_username
  location                      = var.location
  name                          = var.name
  network_interface_ids         = [for nic in module.network-interface: nic.id]
  resource_group_name           = var.resource_group_name
  size                          = var.size
  license_type                  = var.license_type
  allow_extension_operations    = var.allow_extension_operations
  availability_set_id           = var.availability_set_id
  capacity_reservation_group_id = var.capacity_reservation_group_id
  computer_name                 = var.computer_name
  custom_data                   = var.custom_data
  dedicated_host_id             = var.dedicated_host_id
  dedicated_host_group_id       = var.dedicated_host_group_id
  edge_zone                     = var.edge_zone
  encryption_at_host_enabled    = var.encryption_at_host_enabled
  eviction_policy               = var.eviction_policy
  extensions_time_budget        = var.extensions_time_budget
  patch_assessment_mode         = var.patch_assessment_mode
  patch_mode                    = var.patch_mode
  max_bid_price                 = var.max_bid_price
  platform_fault_domain         = var.platform_fault_domain
  priority                      = var.priority
  provision_vm_agent            = var.provision_vm_agent
  proximity_placement_group_id  = var.proximity_placement_group_id
  reboot_setting                = var.reboot_setting
  secure_boot_enabled           = var.secure_boot_enabled
  source_image_id               = var.source_image_id
  user_data                     = var.user_data
  vtpm_enabled                  = var.vtpm_enabled
  virtual_machine_scale_set_id  = var.virtual_machine_scale_set_id
  zone                          = var.zone
  bypass_platform_safety_checks_on_user_schedule_enabled = var.bypass_platform_safety_checks_on_user_schedule_enabled

  disable_password_authentication = true

  admin_ssh_key {
    public_key = data.azurerm_ssh_public_key.this.public_key
    username = lookup(var.admin_ssh_key, "username", "azureuser")
  }

  dynamic "os_disk" {
    for_each = toset([var.os_disk])
    content {
      caching                          = var.os_disk.caching
      storage_account_type             = var.os_disk.storage_account_type
      dynamic "diff_disk_settings" {
        for_each = coalesce(lookup(var.os_disk, "diff_disk_settings"), [])
        content {
          option = diff_disk_settings.value.option
          placement = diff_disk_settings.value.placement
        }
      }
      disk_encryption_set_id           = lookup(var.os_disk, "disk_encryption_set_id", null)
      disk_size_gb                     = lookup(var.os_disk, "disk_size_gb", null)
      name                             = lookup(var.os_disk, "name", null)
      secure_vm_disk_encryption_set_id = lookup(var.os_disk, "secure_vm_disk_encryption_set_id", null)
      security_encryption_type         = lookup(var.os_disk, "security_encryption_type", null)
      write_accelerator_enabled        = lookup(var.os_disk, "write_accelerator_enabled", null)
    }
  }

  dynamic "additional_capabilities" {
    for_each = var.additional_capabilities != null ? toset(["additional_capabilities"]) : toset([])
    content {
      ultra_ssd_enabled = lookup(var.additional_capabilities, "ultra_ssd_enabled", null)
      hibernation_enabled = lookup(var.additional_capabilities, "hibernation_enabled", null)
    }
  }

  dynamic "boot_diagnostics" {
    for_each = var.boot_diagnostics != null ? toset([var.boot_diagnostics]) : []
    content {
      storage_account_uri = lookup(boot_diagnostics.value, "storage_account_uri", null)
    }
  }

  dynamic "gallery_application" {
    for_each = var.gallery_application != null ? toset([var.gallery_application]) : []
    content {
      version_id = gallery_application.value.version_id
      configuration_blob_uri = lookup(gallery_application.value, "configuration_blob_uri", null)
      order = lookup(gallery_application.value, "order", null)
      tag = lookup(gallery_application.value, "tag", null)
    }
  }

  dynamic "identity" {
    for_each = var.identity != null ? toset([var.identity]) : []
    content {
      type = identity.value.type
      identity_ids = lookup(identity.value, "identity_ids", null)
    }
  }

  dynamic "plan" {
    for_each = var.plan != null ? toset([var.plan]) : []
    content {
      name      = plan.value.name
      product   = plan.value.product
      publisher = plan.value.publisher
    }
  }

  dynamic "secret" {
    for_each = var.secret
    content {
      dynamic "certificate" {
        for_each = secret.value.certificate
        content {
          url = certificate.value.url
        }
      }
      key_vault_id = secret.value.key_vault_id
    }
  }

  dynamic "source_image_reference" {
    for_each = var.source_image_reference != null ? toset([var.source_image_reference]) : []
    content {
      publisher = source_image_reference.value.publisher
      offer = source_image_reference.value.offer
      sku = source_image_reference.value.sku
      version = source_image_reference.value.version
    }
  }

  dynamic "termination_notification" {
    for_each = var.termination_notification != null ? toset([var.termination_notification]) : []
    content {
      enabled = termination_notification.value.enabled
      timeout = lookup(termination_notification.value,"offer", null)
    }
  }

  tags = var.tags
}
