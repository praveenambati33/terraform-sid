resource "azurerm_windows_web_app" "win-fn" {

  name                = var.appservicename
  resource_group_name = var.resourcegroupname
  location            = var.location

  service_plan_id = var.service_plan_id
  app_settings    = var.app_settings

  site_config {
    ftps_state = "FtpsOnly"
    application_stack {
      node_version = lookup(var.stack_version, "dotnet", null)
    }
    application_insights_key = var.application_insights_key
  }

  tags = var.tags

}
