output "id" {
  value = azurerm_private_dns_resolver_outbound_endpoint.this.id
}
output "forwarding_rulesets" {
  value = module.forwarding_ruleset
}