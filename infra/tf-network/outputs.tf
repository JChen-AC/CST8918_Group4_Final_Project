output "resource_group_name" {
  value       = module.networkresourcegroup.resource_group_name
  description = "tf-network : Resource Group Name"
}

output "vnet_id" {
  value       = azurerm_virtual_network.main.id
  description = "tf-network : Virtual Network ID"
}

output "vnet_name" {
  value       = azurerm_virtual_network.main.name
  description = "tf-network : Virtual Network Name"
}

output "subnet_ids" {
  value       = { for env, subnet in azurerm_subnet.env : env => subnet.id }
  description = "tf-network : Map of environment name to subnet ID (prod, test, dev, admin)"
}

output "subnet_address_prefixes" {
  value       = { for env, subnet in azurerm_subnet.env : env => subnet.address_prefixes[0] }
  description = "tf-network : Map of environment name to subnet CIDR block"
}
