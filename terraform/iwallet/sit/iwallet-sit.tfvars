#Resource Group
resourcegroupname = "eus-sit3-iwallet-rg-02"
location          = "eastus"


applicationinsightsname = "eus-sit2-iwallet-ai"

# JS Function App
nodeserviceplanname    = "eus-sit2-iwallet-js-sp-01"
node_ostype             = "Windows"
node_sku                = "Y1"
nodestorageaccountname = ["eussit2fnappjs09stgacc"]
fn_containers_list = []
nodefunctionappname    = "eus-sit2-iwallet-js-02"
node_stack_version     = { node = "~14" }
nodersvname            = "eus-sit2-iwallet-fnapp-js-rsv-01"
nodersvfspolicyname    = "eus-sit2-iwallet-js-rsv"
node_function_app_application_settings = {
  "tracker_id"      = "AJKGDFJKHFDS"
  "backend_api_url" = "https://backend.domain.tld/api"
}

# Java Function App

javaserviceplanname    = "eus-sit2-iwallet-java-sp-02"
java_ostype             = "Windows"
java_sku                = "Y1"
javastorageaccountname = ["eussit2fnappjava09stgacc"]
javafunctionappname    = "eus-sit2-iwallet-java-01"
java_stack_version     =  { java= "8" }
javarsvname            = "eus-sit2-iwallet-fnapp-java-rsv-01"
javarsvfspolicyname    = "eus-sit2-iwallet-java-rsv"
java_function_app_application_settings = {
  "tracker_id"      = "AJKGDFJKHFDS"
  "backend_api_url" = "https://backend.domain.tld/api"
}


# CosmoDB and Containers
iwalletcosmosdbaccount    = "eus-sit2-db-cosdbsql-01"
iwalletcosmosdb           = "walletDatabase"
iwalletcosmosdbcontainer1 = "leases"
leasepartitionkey         = "/id"
iwalletcosmosdbcontainer2 = "walletCollection"
walletpartitionkey        = "/doctype"

# KeyVault
appkeyvaultname = "eus-sit3-iwallet-kv-01"
cosmoskeyvaultname = "eus-sit2-kv-cosmosdb-01"

# DataFactory
iwalletdfname = "eus-sit2-iwallet-asg"


#Event Hub Namespace and Event Hubs

eventhubstorageaccountname = "eussit2walletslogssa99"

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
storageaccountname = ["eussit2stgacc01backup"]

javacontainerlist = [
  { name = "iwalletlogs", access_type = "private" }
]

nodecontainerlist = [
  { name = "iwalletlogs", access_type = "private" }
]

containers_list = [
  { name = "eus-sit2-iwallet-cosdb-bkp", access_type = "private" }
]

# Application specific tags 

tags = {
  "Application Name" = "IWallet"
  "applicationType"  = "serverless-iwallet"
  "Dept Id"          = "411"
  "Environment"      = "Ent SIT2"
}
