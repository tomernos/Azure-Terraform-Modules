#resource "azurerm_kubernetes_cluster" "aks" {
#  name                = var.cluster_name
#  location            = var.location
#  resource_group_name = var.resource_group_name
#  dns_prefix         = "${var.cluster_name}-dns"
#  kubernetes_version = var.kubernetes_version
#
#  default_node_pool {
#    name                = "default"
#    node_count          = var.node_count
#    vm_size            = var.vm_size
#    vnet_subnet_id     = var.subnet_id
#    enable_auto_scaling = false
#  }
#
#  identity {
#    type = "SystemAssigned"
#  }
#
#  network_profile {
#    network_plugin     = "azure"
#    load_balancer_sku = "basic"
#  }
#
#  tags = var.tags
#}