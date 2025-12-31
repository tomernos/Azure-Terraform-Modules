output "id" {
  value =  azurerm_firewall_policy.this.id 
}
output "child_policies" {
  value =  azurerm_firewall_policy.this.child_policies 
}
output "firewalls" {
  value =  azurerm_firewall_policy.this.firewalls 
}
output "rule_collection_groups" {
  value =  azurerm_firewall_policy.this.rule_collection_groups 
}