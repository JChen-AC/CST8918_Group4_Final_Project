data "azurerm_resource_group" "main" {
  name = "cst8918-final-project-group-4"
}

data "terraform_remote_state" "aks" {
  backend = "azurerm"

  config = {
    resource_group_name  = "cst8918grp4-githubactions-rg"
    storage_account_name = "cst8918grp4githubactions"
    container_name       = "tfstate"
    key                  = "aks.terraform.tfstate"
    use_oidc             = true
  }
}

module "weather_resources" {
  source = "../modules/weather_resources"

  providers = {
    kubernetes.test = kubernetes.test
    kubernetes.prod = kubernetes.prod
  }

  resource_group_name = data.azurerm_resource_group.main.name
  location            = var.region
  label_prefix        = var.label_prefix

  test_kubelet_identity_object_id = data.terraform_remote_state.aks.outputs.test_kubelet_identity_object_id
  prod_kubelet_identity_object_id = data.terraform_remote_state.aks.outputs.prod_kubelet_identity_object_id

  tags = {
    Project = "CST8918-Final"
  }
}