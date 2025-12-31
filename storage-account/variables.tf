
variable "enable_https_traffic_only" {
  type    = bool
  default = true
}
variable "shared_access_key_enabled" {
  type    = bool
  default = true
}
variable "nfsv3_enable" {
  type    = bool
  default = false
}
variable "infrastructure_encryption_enabled" {
  type    = bool
  default = false
}
variable "large_file_share_enabled" {
  type    = bool
  default = null
}
variable "allow_nested_items_to_be_public" {
  type    = bool
  default = false
}
variable "cross_tenant_replication_enabled" {
  type    = bool
  default = false
}
variable "queue_encryption_key_type" {
  type    = string
  default = "Service"
}
variable "table_encryption_key_typ" {
  type    = string
  default = "Service"
}
variable "default_to_oauth_authentication" {
  type    = bool
  default = false
}
variable "location" {
  type = string
}
variable "subnet_id" {
  type = string
  default = null
}
variable "private_dns_zones" {
  type = any
  default = null
}
variable "is_hns_enabled" {
  type    = bool
  default = null
}
variable "min_tls_version" {
  type    = string
  default = "TLS1_2"
}
variable "edge_zone" {
  type    = string
  default = null
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "resource_group_name" {
  type = string
}
variable "name" {
  type = string
}
variable "custom_domain" {
  type    = any
  default = null
}
variable "blob_properties" {
  type    = any
  default = null
}
variable "private_endpoints" {
  type    = any
  default = {}
}
variable "share_properties" {
  type    = any
  default = null
}
variable "queue_properties" {
  type    = any
  default = null
}
variable "customer_managed_key" {
  type    = any
  default = null
}
variable "azure_files_authentication" {
  type    = any
  default = null
}
variable "static_website" {
  type    = map(string)
  default = null
}
variable "identity" {
  type    = map(string)
  default = null
}
variable "network_rules" {
  type    = any
  default = null
}
variable "account_tier" {
  type = string
}
variable "account_replication_type" {
  type = string
}
variable "account_kind" {
  type = string
  default = null
}
variable "access_tier" {
  type = string
  default = null
}
variable "public_network_access_enabled" {
  type = bool
  default = null
}
variable "storage_lifecycle" {
  type = any
  default = false
}