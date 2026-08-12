module "backendresourcegroup" {
  source       = "../modules/resource_group"
  name = "${var.label_prefix}-githubactions-rg"
  region       = var.region
}  

module "backendstorage" {
  source       = "./modules/StorageAccount"
  label_prefix = var.label_prefix
  region       = var.region
  rg_name      = module.backendresourcegroup.resource_group_name
}