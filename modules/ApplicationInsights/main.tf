resource "azurerm_application_insights" "app-ai" {

  name                = var.applicationinsightsname
  resource_group_name = var.resourcegroupname
  location            = var.location
  workspace_id        = var.workspace_id !=  null ? var.workspace_id : null
  application_type    = "web"
  tags                = var.tags

}