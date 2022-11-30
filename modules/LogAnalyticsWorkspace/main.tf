resource "azurerm_log_analytics_workspace" "law-ws" {
  name                = var.lawworkspacename
  resource_group_name = var.resourcegroupname
  location            = var.location
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = var.tags
}