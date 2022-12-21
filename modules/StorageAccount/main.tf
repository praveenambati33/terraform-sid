# resource "azurerm_storage_account" "storageaccount" {

#   name                     = var.storageaccountname
#   resource_group_name      = var.resourcegroupname
#   location                 = var.location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
#   tags = var.tags

# }

# resource "azurerm_storage_container" "container" {

#   count                 = length(var.containers_list)
#   name                  = var.containers_list[count.index].name
#   storage_account_name  = azurerm_storage_account.storageaccount.name
#   container_access_type = var.containers_list[count.index].access_type
  
# }

resource "azurerm_storage_account" "storage_account" {

  for_each = toset(var.storage_list) 
  name=each.value
  resource_group_name = var.resourcegroupname
  location = var.location
  account_tier = "Standard"
  account_replication_type = "LRS"

}

resource "azurerm_storage_container" "container" {
  for_each              = {for idx, val in local.flat_list: idx => val}
  name                  = each.value[1].name
  container_access_type = each.value[1].access_type
  storage_account_name  = azurerm_storage_account.storage_account[each.value[0]].name
}


locals {
    flat_list = setproduct(var.storage_list, var.containers_list)
}