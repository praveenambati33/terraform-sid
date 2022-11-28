resource "azurerm_storage_account" "iwallet-java-sa" {
  name                     = var.javastroageaccountname
  resource_group_name      = var.resourcegroupname
  location                 = var.location
  account_tier             = var.javaaccounttier
  account_replication_type = var.javareplicationtype
  tags = var.tags

}

resource "azurerm_service_plan" "iwallet-java-app-sp" {
  name                = var.javaserviceplanname
  resource_group_name = var.resourcegroupname
  location            = var.location
  os_type             = var.javaostype
  sku_name            = var.javasku
  tags = var.tags
}

resource "azurerm_windows_function_app" "iwallet-java-fun" {
  name                = var.javafunctionappname
  resource_group_name = var.resourcegroupname
  location            = var.location

  storage_account_name       = azurerm_storage_account.iwallet-java-sa.name
  storage_account_access_key = azurerm_storage_account.iwallet-java-sa.primary_access_key
  service_plan_id            = azurerm_service_plan.iwallet-java-app-sp.id

  identity {
    type = "SystemAssigned"
  }

  app_settings = {
    "key" = "value"
  }

  site_config {
    ftps_state = "FtpsOnly"
    application_stack {
      java_version  = var.javastackversion
    }
    application_insights_key = var.fn_ai_key_out
  }
  tags = var.tags
}
