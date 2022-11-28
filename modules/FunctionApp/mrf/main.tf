terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.31.0"
    }
  }
}

resource "azurerm_storage_account" "sa" {
  name                     = var.stroageaccountname
  resource_group_name      = var.resourcegroupname
  location                 = var.location
  account_tier             = var.accounttier
  account_replication_type = var.replicationtype
}

resource "azurerm_service_plan" "appsp" {
  name                = var.serviceplanname
  resource_group_name = var.resourcegroupname
  location            = var.location
  os_type             = var.ostype
  sku_name            = var.sku
}

resource "azurerm_windows_function_app" "win-fn" {
  name                = var.functionappname
  resource_group_name = var.resourcegroupname
  location            = var.location

  storage_account_name       = azurerm_storage_account.sa.name
  storage_account_access_key = azurerm_storage_account.sa.primary_access_key
  service_plan_id            = azurerm_service_plan.appsp.id

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
    application_insights_key = azurerm_application_insights.app-ai.instrumentation_key
  }
}

resource "azurerm_application_insights" "app-ai" {
  name                = var.applicationinsightsname
  resource_group_name = var.resourcegroupname
  location            = var.location
  workspace_id        = azurerm_log_analytics_workspace.law-ws.id
  application_type    = "web"
  
}

resource "azurerm_log_analytics_workspace" "law-ws" {
  name                = var.lawworkspace
  resource_group_name = var.resourcegroupname
  location            = var.location
  sku                 = "PerGB2018"
  retention_in_days   = 30
}
