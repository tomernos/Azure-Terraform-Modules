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
  "spoke-to-hub" = {
    resource_group   = "rg-spoke"
    source_vnet      = "vnet-spoke"
    remote_vnet_key  = "vnet-hub"
    allow_vnet_access = true
    allow_forwarded   = true
    tags = {
      Purpose = "Connectivity"
    }
  }
}

route_tables = {
  "DEX-NE-HUB-UDR" = {
    location       = "northeurope"
    resource_group = "rg-hub"
    tags = {
      Purpose = "Routing"
    }
  }
}

routes = {
  "DEX-NE-HUB_TO_DEX-NE-SPOKE" = {
    resource_group        = "rg-hub"
    route_table_key       = "DEX-NE-HUB-UDR"
    address_prefix        = "10.1.0.0/16"
    next_hop_type         = "VirtualAppliance"
    next_hop_in_ip_address = "10.0.2.4"
  }
}

vms = {
  "vm-hub-linux" = {
    vm_size          = "Standard_B2s"
    subnet_name = "hub-subnet-default"
    resource_group = "rg-hub"
    os_type          = "linux"
    create_public_ip = true
    ssh_public_key   = "ssh-rsa AAAAB3NzaC1yc2EAAAA..." # Your SSH public key
    image = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts-gen2"
      version   = "latest"
    }
  },
  "vm-spoke-windows" = {
    vm_size          = "Standard_B2s"
    subnet_name = "spoke-subnet-default"
    resource_group = "rg-spoke"
    os_type          = "windows"
    create_public_ip = false
    admin_username = "azureuser"
    admin_password = "YourSecurePassword123!"
    image = {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2022-datacenter-g2"
      version   = "latest"
    }
  }
}

