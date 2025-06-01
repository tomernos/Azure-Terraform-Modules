#variable "cluster_name" {
#  description = "Name of the AKS cluster"
#  type        = string
#}
#
#variable "location" {
#  description = "Azure region"
#  type        = string
#}
#
#variable "resource_group_name" {
#  description = "Name of the resource group"
#  type        = string
#}
#
#variable "kubernetes_version" {
#  description = "Kubernetes version"
#  type        = string
#  default     = "1.26.3"
#}
#
#variable "node_count" {
#  description = "Number of nodes in the default node pool"
#  type        = number
#  default     = 1
#}
#
#variable "vm_size" {
#  description = "Size of the VM for nodes"
#  type        = string
#  default     = "Standard_B2s"
#}
#
#variable "subnet_id" {
#  description = "Subnet ID for the node pool"
#  type        = string
#}
#
#variable "tags" {
#  description = "Tags to apply to all resources"
#  type        = map(string)
#  default     = {}
#}