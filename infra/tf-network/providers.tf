# Configure the Terraform runtime requirements.
terraform {
  required_version = ">= 1.1.0"

  # NOTE: backend block intentionally omitted for now — using local state
  # while shared backend access is being sorted out. Restore this before
  # merging to main:
  #
  # backend "azurerm" {
  #   resource_group_name  = "cst8918grp4-githubactions-rg"
  #   storage_account_name = "cst8918grp4githubactions"
  #   container_name       = "tfstate"
  #   key                  = "network.terraform.tfstate"
  #   use_oidc             = true
  # }

  required_providers {
    # Azure Resource Manager provider and version
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

# Define providers and their config params
provider "azurerm" {
  # Leave the features block empty to accept all defaults
  features {}
}
