output "sa_primary_access_key_out"{
    value = { for storageaccount in azurerm_storage_account.storageaccount : storageaccount.name =>  storageaccount.primary_access_key }
    sensitive = true
}


output "sa_name_out"{
    value = { for storageaccount in azurerm_storage_account.storageaccount : storageaccount.name =>  storageaccount.name }
}