terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.9.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.19.0"
    }
  }
  // TODO - the state should not be in the same group as the RG we want to create/destroy :p
  backend "azurerm" {
    resource_group_name  = "RG-Terraform-Hackaton"
    storage_account_name = "terraformhackatonstates"
    container_name       = "state"
    key                  = "terraform.tfstate"
  }

  required_version = ">= 1.1.0"
}