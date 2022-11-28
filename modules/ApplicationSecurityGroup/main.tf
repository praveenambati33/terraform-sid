resource "azurerm_application_security_group" "iwallet-asg" {
  name                = var.iwalletasg
  location            = var.location
  resource_group_name = var.resourcegroupname
  tags = var.tags
}