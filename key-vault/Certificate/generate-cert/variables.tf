
variable "name" {
  type = string
}
variable "key_vault_id" {
  type = string
}

variable "issuer_parameters" {
  type = string
  description = "options Self, Unkown ,Let's Encrypt"
}
variable "key_properties" {
  type = object({
    exportable = bool
    key_type   = string
    reuse_key  = bool
    key_size   = optional(number)
    curve      = optional(string)
  })
  description = <<EOF
   key_type {RSA,EC}
   key_size required if use RSA optional {RSA = 2048,3072,4096 } {EC = 256,384,521}
   curve required if use EC optional will required in future for using EC key_type
EOF
}
variable "lifetime_action" {
  type = map(object({
    action_type = optional(string)
    trigger = object({
      days_before_expiry  = optional(number)
      lifetime_percentage = optional(number)
    })
  }))
  default = null
  description = <<EOF
  days_before_expiry lifetime_percentage choose one of attribute
  if two attribute added create conflicts
EOF
}
variable "secret_properties" {
  type = object({
    content_type = string
  })
  description = "application/x-pkcs12 for pfx or application/x-pem-file for pem"
}
variable "x509_certificate_properties" {
  type = object({
    extended_key_usage = optional(list(string))
    key_usage          = list(string)
    subject            = string
    validity_in_months = number
    subject_alternative_names = optional(map(object({
      dns_names = optional(list(string))
      emails    = optional(list(string))
      upns      = optional(list(string))
    })))
  })
  description = <<EOF
  RSA [cRLSign,dataEncipherment,decipherOnly,digitalSignature,encipherOnly,keyAgreement,keyCertSign,keyEncipherment,nonRepudiation]
  EC [cRLSign,digitalSignature,keyAgreement,keyCertSign,nonRepudiation]
EOF
}

variable "create" {
  type    = bool
  default = true
}