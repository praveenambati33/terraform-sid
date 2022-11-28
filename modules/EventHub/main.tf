resource "azurerm_storage_account" "storageaccount" {

  name                     = var.eventhubstorageaccountname
  resource_group_name      = var.resourcegroupname
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

}

resource "azurerm_storage_container" "container" {
  count                 = length(var.eventhubcontainers_list)
  name                  = var.eventhubcontainers_list[count.index].name
  storage_account_name  = azurerm_storage_account.storageaccount.name
  container_access_type = var.eventhubcontainers_list[count.index].access_type
}


resource "azurerm_eventhub_namespace" "iwallet-ens" {
  depends_on = [
    azurerm_storage_account.storageaccount,
  ]
  name                = var.iwalletensname
  location            = var.location
  resource_group_name = var.resourcegroupname
  sku                 = "Standard"
  capacity            = 1
  minimum_tls_version = "1.1"
}

resource "azurerm_eventhub" "iwallet-eventhubs" {
  for_each            = var.eventhubs
  name                = each.value["eventhubname"]
  namespace_name      = azurerm_eventhub_namespace.iwallet-ens.name
  resource_group_name = var.resourcegroupname
  partition_count     = 4
  message_retention   = 1
  capture_description {
    enabled  = true
    encoding = "Avro"
    destination {
      name                = "EventHubArchive.AzureBlockBlob"
      archive_name_format = "{Namespace}/{EventHub}/{PartitionId}/{Year}-{Month}-{Day}T{Hour}:{Minute}:{Second}"
      blob_container_name = each.value["blob_container_name"]
      storage_account_id  = azurerm_storage_account.storageaccount.id
    }
  }
}