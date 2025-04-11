terraform {
  required_version = ">= 0.12"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
    backend "azurerm" {
    resource_group_name  = "da_aks_rsg"
    storage_account_name = "daaksstorageaccount"
    container_name       = "terraformtfstate"
    key                  = "terraformtfstate/tfstate"
  }
}


provider "azurerm" {
  features {}
}