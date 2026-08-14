# ---------------------------------------------------------------------------
# Existing shared resource group
# ---------------------------------------------------------------------------
data "azurerm_resource_group" "main" {
  name = "cst8918-final-project-group-4"
}

# ---------------------------------------------------------------------------
# Existing VNet created by tf-network
# ---------------------------------------------------------------------------
data "azurerm_virtual_network" "main" {
  name                = "vnet-${var.label_prefix}"
  resource_group_name = data.azurerm_resource_group.main.name
}

# ---------------------------------------------------------------------------
# Existing environment subnets
# ---------------------------------------------------------------------------
data "azurerm_subnet" "test" {
  name                 = "snet-test"
  resource_group_name  = data.azurerm_resource_group.main.name
  virtual_network_name = data.azurerm_virtual_network.main.name
}

data "azurerm_subnet" "prod" {
  name                 = "snet-prod"
  resource_group_name  = data.azurerm_resource_group.main.name
  virtual_network_name = data.azurerm_virtual_network.main.name
}

# ---------------------------------------------------------------------------
# Test AKS cluster
# Requirement:
# - 1 node
# - Standard_B2s
# - Kubernetes 1.32
# ---------------------------------------------------------------------------
module "aks_test" {
  source = "../modules/aks"

  cluster_name        = "aks-${var.label_prefix}-test"
  location            = var.region
  resource_group_name = data.azurerm_resource_group.main.name
  subnet_id           = data.azurerm_subnet.test.id

  vm_size = "standard_b2als_v2"

  auto_scaling_enabled = false
  node_count           = 1

  service_cidr   = "172.16.0.0/16"
  dns_service_ip = "172.16.0.10"

  tags = {
    Environment = "test"
    Project     = "CST8918-Final"
  }
}

# ---------------------------------------------------------------------------
# Production AKS cluster
# Requirement:
# - minimum 1 node
# - maximum 3 nodes
# - Standard_B2s
# - Kubernetes 1.32
# ---------------------------------------------------------------------------
module "aks_prod" {
  source = "../modules/aks"

  cluster_name        = "aks-${var.label_prefix}-prod"
  location            = var.region
  resource_group_name = data.azurerm_resource_group.main.name
  subnet_id           = data.azurerm_subnet.prod.id

  vm_size = "standard_b2als_v2"

  auto_scaling_enabled = true
  min_count            = 1
  max_count            = 3

  service_cidr   = "172.17.0.0/16"
  dns_service_ip = "172.17.0.10"

  tags = {
    Environment = "prod"
    Project     = "CST8918-Final"
  }
}