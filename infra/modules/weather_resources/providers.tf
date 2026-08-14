# Configure the Terraform runtime requirements.
terraform {
  required_version = ">= 1.1.0"

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
    kubernetes = {
      source                = "hashicorp/kubernetes"
      version               = "~> 2.30"
      configuration_aliases = [kubernetes.test, kubernetes.prod]
    }
  }

}