variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}

variable "name" {
  description = "Name for the managed identity"
  type        = string
}

variable "aks_oidc_issuer_url" {
  description = "The OIDC issuer URL of the AKS cluster"
  type        = string
}

variable "role_definitions" {
  description = "List of role definitions to assign to the managed identity"
  type        = list(string)
  default     = []
}

variable "serviceaccount_namespace" {
  type        = string
  description = "Kubernetes namespace for the service account"
}

variable "serviceaccount_name" {
  type        = string
  description = "Name of the Kubernetes service account"
}

variable "scope" {
  type        = string
  description = "Scope for the role assignment"
  default     = null
}
variable "additional_role_assignments" {
  description = "Map of additional resources and their corresponding role names for the managed identity"
  type = map(object({
    resource_id = string
    role_name   = string
  }))
  default = {}
  # default = {
  #   example1 = {
  #     resource_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/exampleResourceGroup/providers/Microsoft.Storage/storageAccounts/exampleStorageAccount"
  #     role_name   = "Storage Blob Data Contributor"
  #   }
  #   example2 = {
  #     resource_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/exampleResourceGroup/providers/Microsoft.KeyVault/vaults/exampleKeyVault"
  #     role_name   = "Key Vault Contributor"
  #   }
}

