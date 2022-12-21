resource "azurerm_storage_account" "storageaccount" {

  for_each = toset(var.storage_list) 
  name=each.value
  resource_group_name = var.resourcegroupname
  location = var.location
  account_tier = "Standard"
  account_replication_type = "LRS"
  tags = var.tags

}

resource "azurerm_storage_container" "container" {
  for_each              = {for idx, val in local.flat_list: idx => val}
  name                  = each.value[1].name
  container_access_type = each.value[1].access_type
  storage_account_name  = azurerm_storage_account.storageaccount[each.value[0]].name
}


locals {
    flat_list = setproduct(var.storage_list, var.containers_list)
}