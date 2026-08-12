# ---------------------------------------------------------------------------
# Shared project Resource Group.
# NOTE: this is the canonical, single resource group for the whole project,
# per the assignment spec. Owned here (Networking) since this is where it's
# assigned. Other components (tf-frontend, AKS, etc.) should look this up via
# a `data "azurerm_resource_group"` block or remote state output instead of
# creating their own — creating a second resource with the same name will
# conflict with this one.
# ---------------------------------------------------------------------------
module "networkresourcegroup" {
  source = "../modules/resource_group"
  name   = "cst8918-final-project-group-4"
  region = var.region
}

# ---------------------------------------------------------------------------
# Virtual Network — 10.0.0.0/14 covers 10.0.0.0 through 10.3.255.255,
# which is exactly the four /16 environment blocks below.
# ---------------------------------------------------------------------------
resource "azurerm_virtual_network" "main" {
  name                = "vnet-${var.label_prefix}"
  address_space       = ["10.0.0.0/14"]
  location            = var.region
  resource_group_name = module.networkresourcegroup.resource_group_name
}

# ---------------------------------------------------------------------------
# Environment subnets — one /16 per environment, second octet = env index
# ---------------------------------------------------------------------------
locals {
  subnets = {
    prod  = "10.0.0.0/16"
    test  = "10.1.0.0/16"
    dev   = "10.2.0.0/16"
    admin = "10.3.0.0/16"
  }
}

resource "azurerm_subnet" "env" {
  for_each             = local.subnets
  name                 = "snet-${each.key}"
  resource_group_name  = module.networkresourcegroup.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [each.value]
}
