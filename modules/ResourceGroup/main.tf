resource "azurerm_resource_group" "iwallet-rg" {
  name     = var.base_name
  location = var.location
}