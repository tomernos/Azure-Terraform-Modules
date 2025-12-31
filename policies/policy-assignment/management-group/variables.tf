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
  default     = null
  description = "The location of the policy assignment.(Optional)"
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

variable "management_group_name" {
  type        = string
  description = "The name of the management group for the policy assignment."
}

variable "not_scopes" {
  type        = list(string)
  default     = []
  description = "A list of resource IDs that are excluded from the policy assignment."
}

variable "parameters" {
  type        = any
  default     = null
  description = "The parameters for the policy assignment, if required."
}

variable "description" {
  type        = string
  default     = null
  description = "The description of the policy assignment."
}

variable "non_compliance_message" {
  type        = string
  default     = null
  description = "The custom non-compliance message for the policy assignment."
}
