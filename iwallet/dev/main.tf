terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.32.0"
    }
  }
}

provider "azurerm" {
  features {}
}


module "ResourceGroup" {
  source = "./ResourceGroup"

  name = "test-rg"
  location = "eastus2"
}