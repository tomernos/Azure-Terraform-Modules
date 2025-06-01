#locals {
#  is_linux   = var.os_type == "linux"
#  is_windows = var.os_type == "windows"
#  
#  default_image = {
#    linux = {
#      publisher = "Canonical"
#      offer     = "UbuntuServer"
#      sku       = "18.04-LTS"
#    }
#    windows = {
#      publisher = "MicrosoftWindowsServer"
#      offer     = "WindowsServer"
#      sku       = "2019-Datacenter"
#    }
#  }
#
#  image_publisher = var.image_publisher != null ? var.image_publisher : local.default_image[var.os_type].publisher
#  image_offer     = var.image_offer != null ? var.image_offer : local.default_image[var.os_type].offer
#  image_sku       = var.image_sku != null ? var.image_sku : local.default_image[var.os_type].sku
#}
#
#resource "azurerm_public_ip" "vm" {
#  name                = "${var.vm_name}-pip"
#  location            = var.location
#  resource_group_name = var.resource_group_name
#  allocation_method   = "Dynamic"
#  tags                = var.tags
#}
#
#resource "azurerm_network_interface" "vm" {
#  name                = "${var.vm_name}-nic"
#  location            = var.location
#  resource_group_name = var.resource_group_name
#
#  ip_configuration {
#    name                          = "internal"
#    subnet_id                     = var.subnet_id
#    private_ip_address_allocation = "Dynamic"
#    public_ip_address_id         = azurerm_public_ip.vm.id
#  }
#
#  tags = var.tags
#}
#
#resource "azurerm_linux_virtual_machine" "vm" {
#  count               = local.is_linux ? 1 : 0
#  name                = var.vm_name
#  resource_group_name = var.resource_group_name
#  location            = var.location
#  size                = var.vm_size
#  admin_username      = var.admin_username
#  
#  admin_ssh_key {
#    username   = var.admin_username
#    public_key = var.ssh_public_key
#  }
#
#  network_interface_ids = [azurerm_network_interface.vm.id]
#
#  os_disk {
#    caching              = "ReadWrite"
#    storage_account_type = "Standard_LRS"
#  }
#
#  source_image_reference {
#    publisher = local.image_publisher
#    offer     = local.image_offer
#    sku       = local.image_sku
#    version   = "latest"
#  }
#
#  tags = var.tags
#}
#
#resource "azurerm_windows_virtual_machine" "vm" {
#  count               = local.is_windows ? 1 : 0
#  name                = var.vm_name
#  resource_group_name = var.resource_group_name
#  location            = var.location
#  size                = var.vm_size
#  admin_username      = var.admin_username
#  admin_password      = var.admin_password
#  
#  network_interface_ids = [azurerm_network_interface.vm.id]
#
#  os_disk {
#    caching              = "ReadWrite"
#    storage_account_type = "Standard_LRS"
#  }
#
#  source_image_reference {
#    publisher = local.image_publisher
#    offer     = local.image_offer
#    sku       = local.image_sku
#    version   = "latest"
#  }
#
#  tags = var.tags
#}