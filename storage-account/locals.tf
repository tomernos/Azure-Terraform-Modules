locals {
  lifecycle = {
    rules = {
        "cool to cold" = {
            enabled = true
            filters = {
                blob_types = ["blockBlob"]
                prefix_match = ["shared-devstations/"]
            }
            actions = {
                base_blob = {
                    tier_to_cool_after_days_since_modification_greater_than = 30
                    tier_to_cold_after_days_since_modification_greater_than  = 90
                }
            }
        }
    }
  }
}