

data "azurerm_management_group" "mg" {
  for_each             = var.create && var.management_group_name != null  ? toset(["mg"]) : toset([])
  name          = var.management_group_name
}

resource "azurerm_policy_definition" "policydef" {
  for_each             = var.create ? toset(["policydef"]) : toset([])
  name                  = var.name
  policy_rule           = var.policy_rule
  description           = var.description
  policy_type           = var.policy_type
  mode                  = var.mode
  management_group_id = try(data.azurerm_management_group.mg["mg"].id, null)
  display_name          = var.display_name
  metadata              = var.metadata
  parameters            = var.parameters
}

data "azurerm_policy_definition" "policydef" {
  display_name                = var.create ? azurerm_policy_definition.policydef["policydef"].display_name : var.display_name
}