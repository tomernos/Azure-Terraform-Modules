variable "name" {
  type        = string
  description = "The name of the policy assignment."
}
variable "policy_definition_id" {
  type        = string
  description = "The ID of the policy definition to assign."
}
variable "create" {
  type        = bool
  default     = true
  description = "Determines whether the policy assignment should be created."
}
variable "location" {
  type        = string
  description = "The location of the policy assignment.(optional)"
}
variable "identity_type" {
  type        = string
  default     = null
  description = "The type of managed identity to assign to the policy (e.g., 'UserAssigned')."
}
variable "enforce" {
  type        = bool
  default     = true
  description = "Specifies whether the policy assignment should be enforced."
}
variable "subscription_id" {
  type        = string
  description = "The subscription ID where the policy assignment will be created."
}
variable "not_scopes" {
  type        = list(string)
  default     = []
  description = "A list of resource IDs to exclude from the policy assignment."
}
variable "parameters" {
  type        = any
  description = "The parameters for the policy assignment, if required by the policy definition."
}
variable "description" {
  type        = string
  default     = null
  description = "The description of the policy assignment."
}
