#variable "resource_group_name" {
#  description = "Name of the resource group"
#  type        = string
#}
#
#variable "location" {
#  description = "Azure region where resources will be created"
#  type        = string
#}
#
#variable "vm_name" {
#  description = "Name of the virtual machine"
#  type        = string
#}
#
#variable "os_type" {
#  description = "Type of the VM OS"
#  type        = string
#  default     = "linux"  # or "windows"
#}
#
#variable "vm_size" {
#  description = "Size of the virtual machine"
#  type        = string
#  default     = "Standard_B2s"
#}
#
#variable "subnet_id" {
#  description = "ID of the subnet where the VM should be connected"
#  type        = string
#}
#
#variable "admin_username" {
#  description = "Admin username for the virtual machine"
#  type        = string
#}
#
#variable "ssh_public_key" {
#  description = "SSH public key for VM authentication"
#  type        = string
#}
#
#variable "image_publisher" {
#  description = "Publisher of the VM image"
#  type        = string
#  default     = "Canonical"
#}
#
#variable "image_offer" {
#  description = "Offer of the VM image"
#  type        = string
#  default     = "UbuntuServer"
#}
#
#variable "image_sku" {
#  description = "SKU of the VM image"
#  type        = string
#  default     = "18.04-LTS"
#}
#
#variable "tags" {
#  description = "Tags to apply to all resources"
#  type        = map(string)
#  default     = {}
#}
#
#variable "admin_password" {
#  description = "Password for Windows VM admin account"
#  type        = string
#  sensitive   = true
#  default     = null
#
#  validation {
#    condition     = var.admin_password == null || length(var.admin_password) >= 12
#    error_message = "Admin password must be at least 12 characters long."
#  }
#}