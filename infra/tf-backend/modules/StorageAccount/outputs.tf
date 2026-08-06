output "resource_group_name" {
  value = azurerm_resource_group.rg.name
  description = "tf-backend : Resource Group Name"

}
output "storage_account_name" {
  value = azurerm_storage_account.storage.name
  description = "tf-backend : Storage Account Name"
}
output "container_name" {
  value = azurerm_storage_container.container.name
  description = "tf-backend : Container Name"
}
