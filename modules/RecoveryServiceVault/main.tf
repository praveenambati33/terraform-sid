resource "azurerm_recovery_services_vault" "vault" {
  name                = var.rsvname
  location            = var.location
  resource_group_name = var.resourcegroupname
  sku                 = "Standard"
}


resource "azurerm_backup_policy_file_share" "example" {
  name                = var.rsvfspolicyname
  resource_group_name = var.resourcegroupname
  recovery_vault_name = azurerm_recovery_services_vault.vault.name

  backup {
    frequency = "Daily"
    time      = "23:30"
  }

  retention_daily {
    count = 30
  }
}