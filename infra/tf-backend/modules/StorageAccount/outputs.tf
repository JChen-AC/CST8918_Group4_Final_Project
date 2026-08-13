output "storage_account_name" {
  value       = azurerm_storage_account.storage.name
  description = "tf-backend : Storage Account Name"
}
output "container_name" {
  value       = azurerm_storage_container.container.name
  description = "tf-backend : Container Name"
}

output "arm_access_key" {
  value       = azurerm_storage_account.storage.primary_access_key
  description = "tf-backend : ARM Access Key"
  sensitive   = true
}