# Configure the Terraform runtime requirements.
terraform {
  required_version = ">= 1.1.0"
  backend "azurerm" {
    resource_group_name  = modules.backendresourcegroup.resource_group_name
    storage_account_name = modules.backendstorage.storage_account_name
    container_name       = "tfstate"
    key                  = "prod.app.tfstate"
    use_oidc             = true
  }
  required_providers {
    # Azure Resource Manager provider and version
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.3"
    }
  }
}

# Define providers and their config params
provider "azurerm" {
  # Leave the features block empty to accept all defaults
  features {}
  use_oidc = true
  
}

provider "cloudinit" {
  # Configuration options
}