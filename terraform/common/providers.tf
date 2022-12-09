# terraform {
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = "3.31.0"

#     }
#   }
#   backend "azurerm" {}
# }

# provider "azurerm" {
#   features {}
# }


terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.31.0"

    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  subscription_id = "0c08f7e9-e572-4fca-b0ca-b9acf0eeda26"
  tenant_id       = "9368fb9d-c4cb-4aec-843b-dda0af9beb59"
  client_id       = "bc80739e-8a9c-447c-869c-fa7cf61532f7"
  client_secret   = "Zj28Q~ck4aBCO7.VD.xQj5YjPGGpERW3TPmkZdwE"
}