resource "azurerm_public_ip" "vm_pip" {
  for_each = {
    for k, v in var.vms : k => v
    if lookup(v, "create_public_ip", false) == true
  }

  name                = "${each.key}-pip"
  location            = var.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_network_interface" "nic" {
  for_each = var.vms

  name                = "${each.key}-nic"
  location            = var.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.subnet_ids[each.value.subnet_name]
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = lookup(each.value, "create_public_ip", false) ? azurerm_public_ip.vm_pip[each.key].id : null
  }

  tags = var.tags
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  for_each = {
    for k, v in var.vms : k => v
    if v.os_type == "linux"
  }

  name                = each.key
  resource_group_name = each.value.resource_group_name
  location            = var.location
  size                = each.value.vm_size
  admin_username      = each.value.admin_username

  disable_password_authentication = lookup(each.value, "disable_password_authentication", true)

  dynamic "admin_ssh_key" {
    for_each = lookup(each.value, "ssh_public_key", null) != null ? [1] : []
    content {
      username   = each.value.admin_username
      public_key = each.value.ssh_public_key
    }
  }

  network_interface_ids = [azurerm_network_interface.nic[each.key].id]

  os_disk {
    caching              = lookup(each.value, "os_disk_caching", "ReadWrite")
    storage_account_type = lookup(each.value, "os_disk_type", "Standard_LRS")
  }

  source_image_reference {
    publisher = each.value.image.publisher
    offer     = each.value.image.offer
    sku       = each.value.image.sku
    version   = each.value.image.version
  }

  tags = var.tags
}

resource "azurerm_windows_virtual_machine" "windows_vm" {
  for_each = {
    for k, v in var.vms : k => v
    if v.os_type == "windows"
  }

  name                = each.key
  resource_group_name = each.value.resource_group_name
  location            = var.location
  size                = each.value.vm_size
  admin_username      = each.value.admin_username
  admin_password      = each.value.admin_password

  network_interface_ids = [azurerm_network_interface.nic[each.key].id]

  os_disk {
    caching              = lookup(each.value, "os_disk_caching", "ReadWrite")
    storage_account_type = lookup(each.value, "os_disk_type", "Standard_LRS")
  }

  source_image_reference {
    publisher = each.value.image.publisher
    offer     = each.value.image.offer
    sku       = each.value.image.sku
    version   = each.value.image.version
  }

  tags = var.tags
}
