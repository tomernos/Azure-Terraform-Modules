resource "azurerm_security_center_subscription_pricing" "this" {
  tier          = var.tier
  resource_type = var.resource_type
  subplan = var.subplan
  dynamic "extension" {
    for_each = var.extensions
    content {
      name = extension.key
      additional_extension_properties = lookup(extension.value, "additional_extension_properties", null)
    }
  }
}