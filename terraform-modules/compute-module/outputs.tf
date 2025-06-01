#output "vm_id" {
#  description = "ID of the created virtual machine"
#  value       = try(local.is_linux ? azurerm_linux_virtual_machine.vm[0].id : azurerm_windows_virtual_machine.vm[0].id, null)
#}
#output "vm_private_ip" {
#  description = "Private IP address of the virtual machine"
#  value       = try(azurerm_network_interface.vm.private_ip_address, null)
#}
#output "vm_public_ip" {
#  description = "Public IP address of the virtual machine"
#  value       = try(azurerm_public_ip.vm.ip_address, null)
#}