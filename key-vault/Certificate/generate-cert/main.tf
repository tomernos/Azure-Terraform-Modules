resource "azurerm_key_vault_certificate" "this" {
  name         = var.name
  key_vault_id = var.key_vault_id

  certificate_policy {

    issuer_parameters {
      name = var.issuer_parameters 
    }
    dynamic "key_properties" {
      for_each = var.key_properties != null ? toset(["key_properties"]) : toset([])
      content {
        exportable = var.key_properties.exportable
        key_type   = var.key_properties.key_type 
        reuse_key  = var.key_properties.reuse_key
        key_size   = contains(["RSA"], var.key_properties.key_type) && contains([2048, 3072, 4090], var.key_properties.key_size) ? var.key_properties.key_size : contains([256, 384, 521], var.key_properties.key_size) ? var.key_properties.key_size : null # required if use RSA optional {RSA = 2048,3072,4096 } {EC = 256,384,521} 
        curve      = contains(["EC", "EC-HSM"], var.key_properties.key_type) ? var.key_properties.curve : null                                                                                                                                               # required if use EC optional will required in future for using EC key_type
      }
    }
    dynamic "lifetime_action" {
      for_each = var.lifetime_action != null ? toset(["lifetime_action"]) : toset([])
      content {
        dynamic "action" {
          for_each = var.lifetime_action.action != null ? toset(["action"]) : toset([])
          content {
            action_type = var.lifetime_action.action_type
          }
        }
        dynamic "trigger" {
          for_each = var.lifetime_action.trigger != null ? toset(["trigger"]) : toset([])
          content {
            days_before_expiry  = can(var.lifetime_action.trigger.lifetime_percentage) ? null : var.lifetime_action.trigger.days_before_expiry
            lifetime_percentage = can(var.lifetime_action.trigger.days_before_expiry) ? null : var.lifetime_action.trigger.lifetime_percentage
          }
        }
      }
    }
    secret_properties {
      content_type = var.secret_properties.content_type 
    }
    dynamic "x509_certificate_properties" {
      for_each = var.x509_certificate_properties != null ? toset(["x509_certificate_properties"]) : toset([])
      content {
        key_usage          = var.x509_certificate_properties.key_usage
        extended_key_usage = var.x509_certificate_properties.extended_key_usage
        subject            = var.x509_certificate_properties.subject
        validity_in_months = var.x509_certificate_properties.validity_in_months


        dynamic "subject_alternative_names" {
          for_each = var.x509_certificate_properties.subject_alternative_names != null ? toset(["subject_alternative_names"]) : toset([])
          content {
            dns_names = var.subject_alternative_names.dns_names
            emails    = var.subject_alternative_names.emails
            upns      = var.subject_alternative_names.upns
          }
        }
      }
    }
  }
}
