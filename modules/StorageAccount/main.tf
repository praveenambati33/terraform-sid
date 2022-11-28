resource "azurerm_storage_account" "storageaccount" {

  name                     = var.storageaccountname
  resource_group_name      = var.resourcegroupname
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = var.tags

}

resource "azurerm_storage_container" "container" {

  count                 = length(var.containers_list)
  name                  = var.containers_list[count.index].name
  storage_account_name  = azurerm_storage_account.storageaccount.name
  container_access_type = var.containers_list[count.index].access_type
  
}