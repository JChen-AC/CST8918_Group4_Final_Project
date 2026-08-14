terraform {
  required_version = ">= 1.1.0"

  backend "azurerm" {
    resource_group_name  = "cst8918grp4-githubactions-rg"
    storage_account_name = "cst8918grp4githubactions"
    container_name       = "tfstate"
    key                  = "acr-redis.terraform.tfstate"
    use_oidc             = true
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.30"
    }
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
}

provider "kubernetes" {
  alias                  = "test"
  host                   = data.terraform_remote_state.aks.outputs.test_kubelet_config.host
  client_certificate     = base64decode(data.terraform_remote_state.aks.outputs.test_kubelet_config.client_certificate)
  client_key             = base64decode(data.terraform_remote_state.aks.outputs.test_kubelet_config.client_key)
  cluster_ca_certificate = base64decode(data.terraform_remote_state.aks.outputs.test_kubelet_config.cluster_ca_certificate)
}

provider "kubernetes" {
  alias                  = "prod"
  host                   = data.terraform_remote_state.aks.outputs.prod_kubelet_config.host
  client_certificate     = base64decode(data.terraform_remote_state.aks.outputs.prod_kubelet_config.client_certificate)
  client_key             = base64decode(data.terraform_remote_state.aks.outputs.prod_kubelet_config.client_key)
  cluster_ca_certificate = base64decode(data.terraform_remote_state.aks.outputs.prod_kubelet_config.cluster_ca_certificate)
}