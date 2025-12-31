output "id" {
  value = var.create ? azurerm_subscription_policy_assignment.policyAssignmentSUB["policyAssignment"].id : data.azurerm_policy_assignment.policyAssignment.id
}

output "name" {
  value = var.create ? azurerm_subscription_policy_assignment.policyAssignmentSUB["policyAssignment"].name : data.azurerm_policy_assignment.policyAssignment.name
}


