module "user_managed_identity" {
  source = "../../../user-assigned-identity"

  for_each = var.identity_type == "UserAssigned" ? toset(["user-assigned"]) : toset([])

  name = "${var.name}-identity"
  resource_group_name = "rg-policies-managed-identity"
  location            = "eastus"
}

resource "azurerm_subscription_policy_assignment" "policyAssignmentSUB" {
  for_each             = var.create ? toset(["policyAssignment"]) : toset([])
  policy_definition_id = var.policy_definition_id
  name                 = var.name
  subscription_id      = var.subscription_id
  description          = var.description
  parameters           = var.parameters
  enforce              = var.enforce
  location             = var.location
  not_scopes           = var.not_scopes
  dynamic "identity" {
    for_each = var.identity_type != null ? toset(["identity"]) : []
    content {
      type = var.identity_type
      identity_ids = var.identity_type == "UserAssigned" ? [ module.user_managed_identity["user-assigned"].id ] : null
    }
  }
  lifecycle {
    ignore_changes = [
      policy_definition_id
    ]
  }
}


module "rbac" {
  source =  "../../../role-assignment"
  for_each             = var.identity_type != null ? toset(["policyAssignment"]) : toset([])
  role_definition_name = "Contributor"
  scope       = var.subscription_id
  principal_id  = azurerm_subscription_policy_assignment.policyAssignmentSUB["policyAssignment"].identity[0].principal_id
}

data "azurerm_policy_assignment" "policyAssignment" {
  name                = var.create ? azurerm_subscription_policy_assignment.policyAssignmentSUB["policyAssignment"].name : var.name
  scope_id            = var.subscription_id
}