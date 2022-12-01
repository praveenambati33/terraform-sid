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
  alias           = "devsub"
  subscription_id = data.azurerm_key_vault_secret.devsubid.value
  tenant_id       = data.azurerm_key_vault_secret.devtenantid.value
  client_id       = data.azurerm_key_vault_secret.devclientid.value
  client_secret   = data.azurerm_key_vault_secret.devclientidsecret.value
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}


provider "azurerm" {
  alias           = "sharedsub"
  subscription_id = data.azurerm_key_vault_secret.sharedsubid.value
  tenant_id       = data.azurerm_key_vault_secret.sharedtenantid.value
  client_id       = data.azurerm_key_vault_secret.sharedclientid.value
  client_secret   = data.azurerm_key_vault_secret.sharedclientidsecret.value
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

data "azurerm_key_vault" "devops-kv" {
  
  name                = "mykeyvault"
  resource_group_name = "dev-terraform-rg"
}

data "azurerm_key_vault_secret" "sharedclientid" {
  name         = "shared-clientid"
  key_vault_id = data.azurerm_key_vault.devops-kv.id
}

data "azurerm_key_vault_secret" "sharedtenantid" {
  name         = "shared-sharedtenantid"
  key_vault_id = data.azurerm_key_vault.devops-kv.id
}


data "azurerm_key_vault_secret" "sharedclientidsecret" {
  name         = "shared-client-secret"
  key_vault_id = data.azurerm_key_vault.devops-kv.id
}


data "azurerm_key_vault_secret" "sharedsubid" {
  name         = "shared-sub-id"
  key_vault_id = data.azurerm_key_vault.devops-kv.id
}


data "azurerm_key_vault_secret" "devtenantid" {
  name         = "dev-tenantid"
  key_vault_id = data.azurerm_key_vault.devops-kv.id
}

data "azurerm_key_vault_secret" "devclientid" {
  name         = "dev-clientid"
  key_vault_id = data.azurerm_key_vault.devops-kv.id
}


data "azurerm_key_vault_secret" "devclientidsecret" {
  name         = "dev-client-secret"
  key_vault_id = data.azurerm_key_vault.devops-kv.id
}


data "azurerm_key_vault_secret" "devsubid" {
  name         = "dev-sub-id"
  key_vault_id = data.azurerm_key_vault.devops-kv.id
}


resource "azurerm_resource_group" "spoke-rg" {
  provider = azurerm.devsub
  name     = "eus-perf-network-rg"
  location = "eastus"
}

resource "azurerm_virtual_network" "spoke-vnet" {
  provider            = azurerm.devsub
  name                = "eus-perf-vnet"
  resource_group_name = azurerm_resource_group.spoke-rg.name
  address_space       = ["172.29.160.0/22"]
  location            = azurerm_resource_group.spoke-rg.location
}

resource "azurerm_subnet" "spoke-app-subnet" {
  provider            = azurerm.devsub
  name                 = "eus-prod-tableau-snet"
  resource_group_name  = azurerm_resource_group.spoke-rg.name
  virtual_network_name = azurerm_virtual_network.spoke-vnet.name
  address_prefixes     = ["172.29.162.0/27"]
}

resource "azurerm_subnet" "app-delegation-subnet" {
  provider            = azurerm.devsub
  name                 = "eus-jarvisbot-appservice-subnet"
  resource_group_name  = azurerm_resource_group.spoke-rg.name
  virtual_network_name = azurerm_virtual_network.spoke-vnet.name
  address_prefixes     = ["172.29.160.0/27"]

  delegation {
    name = "webapp-delegation"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
    }
  }
}

# PEERING HUB and SPOKE

resource "azurerm_virtual_network_peering" "spoketohub" {
  provider                     = azurerm.devsub
  name                         = "spoketohub"
  resource_group_name          = azurerm_resource_group.spoke-rg.name
  virtual_network_name         = azurerm_virtual_network.spoke-vnet.name
  remote_virtual_network_id    = data.azurerm_virtual_network.hub-vnet.id
  allow_virtual_network_access = "true"
  allow_forwarded_traffic      = "true"
}


resource "azurerm_virtual_network_peering" "hubtospoke" {
  provider                     = azurerm.sharedsub
  name                         = "hubtospoke"
  resource_group_name          = data.azurerm_virtual_network.hub-vnet.resource_group_name
  virtual_network_name         = data.azurerm_virtual_network.hub-vnet.name
  remote_virtual_network_id    = azurerm_virtual_network.spoke-vnet.id
  allow_virtual_network_access = "true"
  allow_forwarded_traffic      = "true"
}

data "azurerm_virtual_network" "hub-vnet" {
  provider            = azurerm.sharedsub
  name                = "hub-vnet"
  resource_group_name = "hub-rg"
}

output "virtual_network_id" {
  value = data.azurerm_virtual_network.hub-vnet.id
}