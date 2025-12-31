variable "postgresql_server_name" {
  description = "The name of the PostgreSQL server."
  type        = string
}

variable "location" {
  description = "The location where the resource will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "administrator_login" {
  description = "The administrator login name for the PostgreSQL server."
  type        = string
}

variable "sku_name" {
  description = "Specifies the SKU Name for this PostgreSQL Server. The name of the SKU, follows the tier + family + cores pattern (e.g. B_Gen4_1, GP_Gen5_8). For more information see the product documentation. Possible values are B_Gen4_1, B_Gen4_2, B_Gen5_1, B_Gen5_2, GP_Gen4_2, GP_Gen4_4, GP_Gen4_8, GP_Gen4_16, GP_Gen4_32, GP_Gen5_2, GP_Gen5_4, GP_Gen5_8, GP_Gen5_16, GP_Gen5_32, GP_Gen5_64, MO_Gen5_2, MO_Gen5_4, MO_Gen5_8, MO_Gen5_16 and MO_Gen5_32."
  type        = string
}

variable "pg_version" {
  description = "Specifies the version of PostgreSQL to use. Valid values are 9.5, 9.6, 10, 10.0, 10.2 and 11. Changing this forces a new resource to be created."
  type        = string
  default     = "16"
}

variable "storage_mb" {
  description = "The storage size in MB for the PostgreSQL server."
  type        = number
}

variable "subnet_id" {
  description = "The ID of the subnet for the private endpoint."
  type        = string
}

variable "backup_retention_days" {
  description = "The number of days to retain backups."
  type        = number
  default     = 7
}

variable "geo_redundant_backup_enabled" {
  description = "Whether geo-redundant backup is enabled."
  type        = bool
  default     = false
}

variable "auto_grow_enabled" {
  description = "Whether auto-grow is enabled."
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled."
  type        = bool
  default     = true
}

variable "ssl_enforcement_enabled" {
  description = "Whether SSL enforcement is enabled."
  type        = bool
  default     = false
}

variable "ssl_minimal_tls_version_enforced" {
  description = "The minimal TLS version enforced for SSL."
  type        = string
  default     = "TLS1_2"
}

variable "env" {
  description = "The environment for the PostgreSQL server (e.g., dev, stg, prod)."
  type        = string
}

variable "private_dns_zones" {
  description = "A map of private DNS zones."
  type        = map(any)
}
variable "private_endpoint" {
  description = "Flag to determine if a private endpoint should be created."
  type        = bool
  default     = false
}

variable "high_availability_mode" {
  description = "The high availability mode for the PostgreSQL server."
  type        = string
  default     = "SameZone"
}
