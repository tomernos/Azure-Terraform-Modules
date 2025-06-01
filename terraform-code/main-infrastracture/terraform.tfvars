# Network Configuration
resource_groups = {
  "rg-hub" = {
    location = "northeurope"
    tags = {
      Environment = "hub"
    }
  },
  "rg-spoke" = {
    location = "northeurope"
    tags = {
      Environment = "spoke"
    }
  }
}

vnets = {
  "vnet-hub" = {
    location        = "northeurope"
    resource_group  = "rg-hub"
    address_space   = ["10.0.0.0/16"]
    tags = {
      Environment = "hub"
    }
  },
  "vnet-spoke" = {
    location        = "northeurope"
    resource_group  = "rg-spoke"
    address_space   = ["10.1.0.0/16"]
    tags = {
      Environment = "spoke"
    }
  }
}

subnets = {
  "hub-subnet-default" = {
    resource_group  = "rg-hub"
    virtual_network = "vnet-hub"
    cidr            = ["10.0.1.0/24"]
    tags = {
      Role = "app"
    }
  },
  "spoke-subnet-default" = {
    resource_group  = "rg-spoke"
    virtual_network = "vnet-spoke"
    cidr            = ["10.1.1.0/24"]
    tags = {
      Role = "app"
    }
  }
}

peerings = {
  "hub-to-spoke" = {
    resource_group   = "rg-hub"
    source_vnet      = "vnet-hub"
    remote_vnet_key  = "vnet-spoke"
    allow_vnet_access = true
    allow_forwarded   = true
    tags = {
      Purpose = "Connectivity"
    }
  }
}

vnet_ids = {
  "vnet-hub"   = "vnet-hub-id"
  "vnet-spoke" = "vnet-spoke-id"
}
