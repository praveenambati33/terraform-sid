resource "azurerm_data_factory" "example" {
  name                = var.iwalletdfname
  location            = var.location
  resource_group_name = var.resourcegroupname
  identity {
    type = "SystemAssigned"
  }
  tags = var.tags
}

