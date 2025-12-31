output "id" {
  value = var.create ? azurerm_management_group_policy_assignment.policyAssignmentmg["policyAssignment"].id : data.azurerm_policy_assignment.policyAssignment.id
}

output "name" {
  value = var.create ? azurerm_management_group_policy_assignment.policyAssignmentmg["policyAssignment"].name : data.azurerm_policy_assignment.policyAssignment.name
}


