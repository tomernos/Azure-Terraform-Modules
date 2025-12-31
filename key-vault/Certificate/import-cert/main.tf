resource "azurerm_key_vault_certificate" "this" {
  name         = var.name
  key_vault_id = var.key_vault_id

  certificate {
    contents = filebase64(var.certificate.contents)
    password = var.certificate.password
  }

}

