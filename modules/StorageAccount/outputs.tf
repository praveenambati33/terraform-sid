output "sa_primary_access_key_out"{
    value = azurerm_storage_account.storageaccount.primary_access_key
}


output "sa_name_out"{
    value = azurerm_storage_account.storageaccount.name
}