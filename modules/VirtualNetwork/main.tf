resource "azurerm_virtual_network" "vnet" {

  name                  = var.vnet_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  address_space         = var.address_space
  tags                  = var.tags

}

#working
# resource "azurerm_virtual_network" "vnet" {

#   name                = var.vnet_name
#   location            = var.location
#   resource_group_name = var.centralhub_resourcegroupname
#   address_space       = var.vnet_address_space
#   tags                = var.tags

#     dynamic "ddos_protection_plan" {
#     for_each = var.ddos_protection_plan != null ? [var.ddos_protection_plan] : []

#     content {
#       enable = ddos_protection_plan.value.enable
#       id     = ddos_protection_plan.value.id
#     }
#   }

# }