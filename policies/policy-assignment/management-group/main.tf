data "azurerm_management_group" "mg" {
  for_each             = var.create ? toset(["mg"]) : toset([])
  name          = var.management_group_name
}

module "user_managed_identity" {
  source = "../../../user-assigned-identity"

  for_each = var.identity_type == "UserAssigned" ? toset(["user-assigned"]) : toset([])

  name = "${var.name}-identity"
  resource_group_name = "rg-policies-managed-identity"
  location            = var.location
}

resource "azurerm_management_group_policy_assignment" "policyAssignmentmg" {
  for_each             = var.create ? toset(["policyAssignment"]) : toset([])
  policy_definition_id = var.policy_definition_id
  name                 = var.name
  management_group_id  = data.azurerm_management_group.mg["mg"].id
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
  dynamic "non_compliance_message" {
    for_each = var.non_compliance_message != null ? [true] : []
    content {
      content = var.non_compliance_message
    }
  }
  lifecycle {
    ignore_changes = [
      policy_definition_id,
      management_group_id,
    ]
  }
}

module "rbac" {
  source =  "../../../role-assignment"
  for_each             = var.identity_type != null ? toset(["policyAssignment"]) : toset([])
  role_definition_name = "Contributor"
  scope       = data.azurerm_management_group.mg["mg"].id
  principal_id  = azurerm_management_group_policy_assignment.policyAssignmentmg["policyAssignment"].identity[0].principal_id
}


data "azurerm_policy_assignment" "policyAssignment" {
  name                = var.create ? azurerm_management_group_policy_assignment.policyAssignmentmg["policyAssignment"].name : var.name
  scope_id            = data.azurerm_management_group.mg["mg"].id
}