terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.31.0"
    }
  }
}

resource "azurerm_storage_account" "iwallet-js-sa" {
  name                     = var.stroageaccountname
  resource_group_name      = var.resourcegroupname
  location                 = var.location
  account_tier             = var.accounttier
  account_replication_type = var.replicationtype

}

resource "azurerm_service_plan" "iwallet-js-app-sp" {
  name                = var.serviceplanname
  resource_group_name = var.resourcegroupname
  location            = var.location
  os_type             = var.ostype
  sku_name            = var.sku
}

resource "azurerm_windows_function_app" "iwallet-js-fun" {
  name                = var.functionappname
  resource_group_name = var.resourcegroupname
  location            = var.location

  storage_account_name       = azurerm_storage_account.iwallet-js-sa.name
  storage_account_access_key = azurerm_storage_account.iwallet-js-sa.primary_access_key
  service_plan_id            = azurerm_service_plan.iwallet-js-app-sp.id

  identity {
    type = "SystemAssigned"
  }

  app_settings = {
    "key" = "value"
  }

  site_config {
    ftps_state = "FtpsOnly"
    application_stack {
      node_version = var.stackversion
    }
    application_insights_key = azurerm_application_insights.iwallet-js-ai.instrumentation_key
  }
}

resource "azurerm_application_insights" "iwallet-js-ai" {
  name                = var.applicationinsightsname
  resource_group_name = var.resourcegroupname
  location            = var.location
  application_type    = "web"
  
}
