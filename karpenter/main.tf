data "azurerm_client_config" "current" {}

resource "azurerm_user_assigned_identity" "karpenter" {
  name                = "karpentermsi-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
}

output "current_subscription_id" {
  value = data.azurerm_client_config.current.subscription_id
}

resource "azurerm_federated_identity_credential" "karpenter" {
  name                = "KARPENTER_FID-${var.environment}"
  resource_group_name = var.resource_group_name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = var.aks_oidc_issuer_url
  parent_id           = azurerm_user_assigned_identity.karpenter.id
  subject             = "system:serviceaccount:${var.karpenter_namespace}:karpenter-sa"
}

resource "azurerm_role_assignment" "virtual_machine_contributor" {
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${var.vnet_resource_group_name}"
  role_definition_name = "Virtual Machine Contributor"
  principal_id         = azurerm_user_assigned_identity.karpenter.principal_id
} 

resource "azurerm_role_assignment" "network_contributor" {
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${var.vnet_resource_group_name}"
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.karpenter.principal_id
}

resource "azurerm_role_assignment" "managed_identity_operator" {
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${var.vnet_resource_group_name}"
  role_definition_name = "Managed Identity Operator"
  principal_id         = azurerm_user_assigned_identity.karpenter.principal_id
}

resource "azurerm_role_assignment" "virtual_machine_contributor_aks_node_resource_group" {
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${var.aks_node_resource_group_id}"
  role_definition_name = "Virtual Machine Contributor"
  principal_id         = azurerm_user_assigned_identity.karpenter.principal_id
}

resource "azurerm_role_assignment" "network_contributor_aks_node_resource_group" {
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${var.aks_node_resource_group_id}"
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.karpenter.principal_id
}

resource "azurerm_role_assignment" "managed_identity_operator_aks_node_resource_group" {
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${var.aks_node_resource_group_id}"
  role_definition_name = "Managed Identity Operator"
  principal_id         = azurerm_user_assigned_identity.karpenter.principal_id
}
