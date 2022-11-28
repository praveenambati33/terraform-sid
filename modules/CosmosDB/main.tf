resource "azurerm_cosmosdb_account" "iwallet-cosmosdb-account" {
  name                = var.iwalletcosmosdbaccount
  location            = var.location
  resource_group_name = var.resourcegroupname
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  enable_automatic_failover = false

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = "eastus"
    failover_priority = 0
  }

  backup {
    type                = "Periodic"
    interval_in_minutes = "240"
    retention_in_hours  = "8"
    storage_redundancy  = "Geo"
  }
}

resource "azurerm_cosmosdb_sql_database" "iwallet-db" {
  name                = var.iwalletcosmosdb
  resource_group_name = azurerm_cosmosdb_account.iwallet-cosmosdb-account.resource_group_name
  account_name        = azurerm_cosmosdb_account.iwallet-cosmosdb-account.name
}

resource "azurerm_cosmosdb_sql_container" "leases-container" {
  name                  = var.iwalletcosmosdbcontainer1
  resource_group_name   = var.resourcegroupname
  account_name          = azurerm_cosmosdb_account.iwallet-cosmosdb-account.name
  database_name         = azurerm_cosmosdb_sql_database.iwallet-db.name
  partition_key_path    = var.leasepartitionkey
  partition_key_version = 1
  throughput            = 400

  indexing_policy {
    indexing_mode = "consistent"

    included_path {
      path = "/*"
    }

    excluded_path {
      path = "/\"_etag\"/?"
    }
  }
}


resource "azurerm_cosmosdb_sql_container" "walletCollection-container" {
  name                  = var.iwalletcosmosdbcontainer2
  resource_group_name   = var.resourcegroupname
  account_name          = azurerm_cosmosdb_account.iwallet-cosmosdb-account.name
  database_name         = azurerm_cosmosdb_sql_database.iwallet-db.name
  partition_key_path    = var.walletpartitionkey
  partition_key_version = 1
  throughput            = 400

  indexing_policy {
    indexing_mode = "consistent"

    included_path {
      path = "/*"
    }

    spatial_index {
      path = "/*"
    }

    excluded_path {
      path = "/\"_etag\"/?"
    }
  }
}