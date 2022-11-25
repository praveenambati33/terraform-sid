terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.31.0"

    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}

    subscription_id = "475ecfec-e18a-4664-a8cd-6e3424489e4b"

}
