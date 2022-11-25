terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.31.0"

    }
  }

  backend "azurerm" {
    subscription_id      = "475ecfec-e18a-4664-a8cd-6e3424489e4b"
    resource_group_name  = "eus-hub-central-devops-rg"
    storage_account_name = "eusdevopsstgacc01"
    container_name       = "iwallet-sit"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}

    # subscription_id = "475ecfec-e18a-4664-a8cd-6e3424489e4b"

}
