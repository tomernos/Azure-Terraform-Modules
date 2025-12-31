output "linux_vm_ids" {
  description = "Map of Linux VM IDs"
  value       = { for k, v in azurerm_linux_virtual_machine.linux_vm : k => v.id }
}

output "windows_vm_ids" {
  description = "Map of Windows VM IDs"
  value       = { for k, v in azurerm_windows_virtual_machine.windows_vm : k => v.id }
}

output "vm_private_ips" {
  description = "Map of VM private IP addresses"
  value       = { for k, v in azurerm_network_interface.nic : k => v.private_ip_address }
}

output "vm_public_ips" {
  description = "Map of VM public IP addresses (only for VMs with public IPs)"
  value       = { for k, v in azurerm_public_ip.vm_pip : k => v.ip_address }
}

output "nic_ids" {
  description = "Map of Network Interface IDs"
  value       = { for k, v in azurerm_network_interface.nic : k => v.id }
}