output "resource_group_name" {
  value       = module.backendresourcegroup.resource_group_name
  description = "tf-backend : Resource Group Name"

}
output "storage_account_name" {
  value       = module.backendstorage.storage_account_name
  description = "tf-backend : Storage Account Name"
}
output "container_name" {
  value       = module.backendstorage.container_name
  description = "tf-backend : Container Name"
}

output "arm_access_key" {
  value       = module.backendstorage.arm_access_key
  description = "tf-backend : ARM Access Key"
  sensitive   = true
}