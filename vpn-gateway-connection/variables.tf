variable "name" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
variable "type" {
  type        = string
  description = " [ IPSec , ExpressRoute , Vnet2Vnet] "
}
variable "virtual_network_gateway_id" {
  type = string
}
variable "local_network_gateway_id" {
  type    = string
  default = null
}
variable "peer_virtual_network_gateway_id" {
  type    = string
  default = null
}
variable "express_route_circuit_id" {
  type    = string
  default = null
}
variable "shared_key" {
  type    = string
  default = null
}
variable "authorization_key" {
  type    = string
  default = null
}
variable "connection_mode" {
  type        = string
  default     = "Default"
  description = <<EOF
  [ Default , InitiatorOnly , ResponderOnly]
  EOF
}

variable "dpd_timeout_seconds" {
  type    = number
  default = null
}
variable "routing_weight" {
  type    = number
  default = 0
}

variable "local_azure_ip_address_enabled" {
  type = bool
  default = null
}
variable "enable_bgp" {
  type    = bool
  default = false
}
variable "express_route_gateway_bypass" {
  type        = bool
  default     = false
  description = <<EOF
  If true, data packets will bypass ExpressRoute Gateway for data forwarding
  This is only valid for ExpressRoute connections
  EOF
}

variable "tags" {
  type    = map(string)
  default = {}
}



variable "egress_nat_rule_ids" {
  type    = list(string)
  default = []
}

variable "ingress_nat_rule_ids" {
  type    = list(string)
  default = []
}
variable "use_policy_based_traffic_selectors" {
  type        = bool
  default     = false
  description = <<EOF
  if true, policy-based traffic selectors are enabled for this connection. 
  Enabling policy-based traffic selectors requires an ipsec_policy block.
  EOF
}

variable "connection_protocol" {
  type        = string
  default     = "IKEv2"
  description = <<EOF
    Note Only valid for IPSec connections on virtual network 
    gateways with SKU VpnGw1 VpnGw2 VpnGw3 VpnGw1AZ VpnGw2AZ or VpnGw3AZ
  EOF
}


variable "traffic_selector_policy" {
  type = object({
    local_address_ranges  = list(string)
    remote_address_ranges = list(string)
  })
  default     = null
  description = <<EOF
   List of local CIDRs
   List of remote CIDRs
  EOF
}

variable "custom_bgp_addresses" {
  type = any
  default = null
  description = <<EOF
   custom_bgp_address {
    primary    = single IP address that is part of the azurerm_virtual_network_gateway ip_configuration (first one)
    secondary  = single IP address that is part of the azurerm_virtual_network_gateway ip_configuration (second one)
   }
   EOF
}

variable "ipsec_policy" {
  type = any
  default = null
  description = <<EOF
  ipsec_policy 
      dh_group                 =  DHGroup1,DHGroup2,DHGroup14,DHGroup24,DHGroup2048,ECP256,ECP384,None 
      ike_encryption           =  DES,DES3,AES128,AES192,AES256 
      ike_integrity            = [ MD5,SHA1,SHA256,SHA384 ]
      ipsec_encryption         = [ AES128,AES192,AES256,DES,DES3,GCMAES128,GCMAES192,GCMAES256,None ]
      ipsec_integrity          = [ GCMAES128,GCMAES192,GCMAES256,MD5,SHA1,SHA256 ]
      pfs_group                = [ PFS1,PFS2,PFS14,PFS24,PFS2048,ECP384,ECP256,None ]
      sa_datasize              = 1024-102400000 KB
      sa_lifetime_sec          = 300-27000 Seconds
  
EOF
}

