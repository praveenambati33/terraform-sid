#Resource Group
resourcegroupname = "eus-sit2-iwallet-rg-02"
location          = "eastus"


# JS Function App
serviceplanname         = "eus-sit2-iwallet-js-sp-01"
ostype                  = "Windows"
sku                     = "Y1"
stroageaccountname      = "eussit2fnappjs01stgacc"
accounttier             = "Standard"
replicationtype         = "LRS"
functionappname         = "eus-sit2-iwallet-js-01"
stackversion            = "~14"
applicationinsightsname = "eus-sit2-iwallet-ai"
rsvname                 = "eus-sit2-iwallet-fnapp-js-rsv-01"
rsvfspolicyname         = "eus-sit2-iwallet-js-rsv"

# Java Function App

javaserviceplanname    = "eus-sit2-iwallet-java-sp-01"
javaostype             = "Windows"
javasku                = "Y1"
javastroageaccountname = "eussit2fnappjava01stgacc"
javaaccounttier        = "Standard"
javareplicationtype    = "LRS"
javafunctionappname    = "eus-sit2-iwallet-java-01"
javastackversion       = "8"
javarsvname            = "eus-sit2-iwallet-fnapp-java-rsv-01"
javarsvfspolicyname    = "eus-sit2-iwallet-java-rsv"


# CosmoDB and Containers
iwalletcosmosdbaccount    = "eus-sit2-db-cosdbsql-01"
iwalletcosmosdb           = "walletDatabase"
iwalletcosmosdbcontainer1 = "leases"
leasepartitionkey         = "/id"
iwalletcosmosdbcontainer2 = "walletCollection"
walletpartitionkey        = "/doctype"

# KeyVault
keyvaultname = "eus-sit2-iwallet-kv-01"

# DataFactory
iwalletdfname = "eus-sit2-iwallet-asg"


#Event Hub Namespace and Event Hubs

eventhubstorageaccountname = "eussit2walletslogssa01"

eventhubcontainers_list = [
  { name = "eus-sit2-iwallet-logs-bkp", access_type = "private" },
  { name = "insights-logs-auditevent", access_type = "private" },
  { name = "insights-logs-dataplanerequests", access_type = "private" },
  { name = "insights-logs-eventhubvnetconnectionevent", access_type = "private" },
  { name = "insights-logs-operationallogs", access_type = "private" },
  { name = "insights-logs-partitionkeystatistics", access_type = "private" },
  { name = "insights-logs-queryruntimestatistics", access_type = "private" },
  { name = "insights-metrics-pt1m", access_type = "private" }
]

iwalletensname = "eus-sit2-iwallet-ehub"

eventhubs = {
  "hub1" = {
    eventhubname        = "insights-logs-auditevent"
    blob_container_name = "insights-logs-auditevent"
  }
  "hub" = {
    eventhubname        = "insights-logs-dataplanerequests"
    blob_container_name = "insights-logs-dataplanerequests"
  }
  "hub3" = {
    eventhubname        = "insights-logs-eventhubvnetconnectionevent"
    blob_container_name = "insights-logs-eventhubvnetconnectionevent"
  }
  "hub4" = {
    eventhubname        = "insights-logs-operationallogs"
    blob_container_name = "insights-logs-operationallogs"
  }
  "hub5" = {
    eventhubname        = "insights-logs-partitionkeystatistics"
    blob_container_name = "insights-logs-partitionkeystatistics"
  }
  "hub6" = {
    eventhubname        = "insights-logs-queryruntimestatistics"
    blob_container_name = "insights-logs-queryruntimestatistics"
  }
  "hub7" = {
    eventhubname        = "insights-metrics-pt1m"
    blob_container_name = "insights-metrics-pt1m"
  }
}

# Application Security Group 
iwalletasg = "eus-sit2-iwallet-asg"

# Storage Account for Cosomo DB Backup 
storageaccountname = "eussit2stgacc01backup"

containers_list = [
  { name = "eus-sit2-iwallet-cosdb-bkp", access_type = "private" }
]

# Application specific tags 

tags = {
    "Application Name" = "IWallet"
    "applicationType" = "serverless-iwallet"
    "Dept Id" = "411"
    "Environment" = "Ent SIT2"
}