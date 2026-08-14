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
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
}