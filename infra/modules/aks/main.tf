resource "azurerm_kubernetes_cluster" "main" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.cluster_name

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name           = "system"
    vm_size        = var.vm_size
    vnet_subnet_id = var.subnet_id

    auto_scaling_enabled = var.auto_scaling_enabled

    node_count = var.auto_scaling_enabled ? null : var.node_count
    min_count  = var.auto_scaling_enabled ? var.min_count : null
    max_count  = var.auto_scaling_enabled ? var.max_count : null
  }

  network_profile {
    network_plugin = "azure"
    service_cidr   = var.service_cidr
    dns_service_ip = var.dns_service_ip
  }

  tags = var.tags
}