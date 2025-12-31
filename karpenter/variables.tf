variable "location" {
  description = "The location where the resource will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "environment" {
  description = "Environment name to be used as a suffix for resource names"
  type        = string
}

variable "aks_oidc_issuer_url" {
  description = "OIDC issuer URL of the AKS cluster"
  type        = string
}

variable "karpenter_namespace" {
  description = "Kubernetes namespace where Karpenter will be installed"
  type        = string
  default     = "karpenter"
}

variable "aks_node_resource_group_id" {
  description = "Resource ID of the AKS node resource group"
  type        = string
}
variable "vnet_resource_group_name" {
  description = "The name of the resource group containing the VNET used by AKS nodes"
  type        = string
}
