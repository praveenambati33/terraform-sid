resource "azurerm_resource_group" "iwallet-rg" {
  name     = var.resourcegroupname
  location = var.location
  tags = var.tags
}