resource "azurerm_service_plan" "app-sp" {
  name                = var.serviceplanname
  resource_group_name = var.resourcegroupname
  location            = var.location
  os_type             = var.ostype
  sku_name            = var.sku
  tags = var.tags
}