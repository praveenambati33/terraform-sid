resource "azurerm_windows_function_app" "win-fn" {
  
  name                = var.functionappname
  resource_group_name = var.resourcegroupname
  location            = var.location

  storage_account_name       = var.storageaccountname
  storage_account_access_key = var.storage_account_access_key
  service_plan_id            = var.service_plan_id

  app_settings = var.function_app_application_settings

  site_config {
    ftps_state = "FtpsOnly"
    application_stack {
      node_version = lookup(var.stack_version, "node", null)
      java_version = lookup(var.stack_version, "java", null)
    }
    application_insights_key = var.application_insights_key
  }

  tags = var.tags

}
