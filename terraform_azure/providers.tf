provider "azurerm" {
  features {}
  
}
terraform {

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.47.0"
      

    }
    
  }
    backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstatemondy123"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    }
}