output "id" {
  value = var.create ? azurerm_policy_definition.policydef["policydef"].id : data.azurerm_policy_definition.policydef.id
}

output "name" {
  value = var.create ? azurerm_policy_definition.policydef["policydef"].name : data.azurerm_policy_definition.policydef.name
}


