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
    resource_group_name  = "tfstatewptetkonklass"
    storage_account_name = "tfstateitsproutdevops"
    container_name       = "tfstatewptetkonklass"
    key                  = "terraform.tfstatewptetkonklass"
    }
}