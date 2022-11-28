module "ResourceGroup" {

  source    = "../../modules/ResourceGroup"
  base_name = var.resourcegroupname
  location  = var.location

}

module "EventHub" {

  depends_on                 = [module.ResourceGroup]
  source                     = "../../modules/EventHub"
  resourcegroupname          = var.resourcegroupname
  location                   = var.location
  eventhubs                  = var.eventhubs
  iwalletensname             = var.iwalletensname
  eventhubstorageaccountname = var.eventhubstorageaccountname
  eventhubcontainers_list    = var.eventhubcontainers_list

}

module "FunctionApp" {

  depends_on        = [module.ResourceGroup]
  source            = "../../modules/FunctionApp/iwallet/windows-nodejs"
  resourcegroupname = var.resourcegroupname
  location          = var.location

  #Service Plan
  serviceplanname = var.serviceplanname
  ostype          = var.ostype
  sku             = var.sku

  #Storage Account
  stroageaccountname = var.stroageaccountname
  accounttier        = var.accounttier
  replicationtype    = var.replicationtype

  #Function App
  functionappname = var.functionappname

  # appsettings = var.appsettings
  stackversion = var.stackversion

  #Applicaiton Insights
  applicationinsightsname = var.applicationinsightsname

}

module "RecoveryServiceVault" {

  depends_on        = [module.FunctionApp]
  source            = "../../modules/RecoveryServiceVault"
  resourcegroupname = var.resourcegroupname
  location          = var.location
  rsvname           = var.rsvname
  rsvfspolicyname   = var.rsvfspolicyname

}

module "FunctionApp2" {

  depends_on        = [module.ResourceGroup]
  source            = "../../modules/FunctionApp/iwallet/windows-java"
  resourcegroupname = var.resourcegroupname
  location          = var.location

  #Service Plan
  javaserviceplanname = var.javaserviceplanname
  javaostype          = var.javaostype
  javasku             = var.javasku

  #Storage Account
  javastroageaccountname = var.javastroageaccountname
  javaaccounttier        = var.javaaccounttier
  javareplicationtype    = var.javareplicationtype

  #Function App
  javafunctionappname = var.javafunctionappname

  # appsettings = var.appsettings
  javastackversion = var.javastackversion

  #Applicaiton Insights
  fn_ai_key_out = module.FunctionApp.fn_ai_key_out

}


module "RecoveryServiceVault2" {

  depends_on        = [module.FunctionApp]
  source            = "../../modules/RecoveryServiceVault"
  resourcegroupname = var.resourcegroupname
  location          = var.location
  rsvname           = var.javarsvname
  rsvfspolicyname   = var.javarsvfspolicyname

}

module "CosomosDB" {

  depends_on                = [module.ResourceGroup]
  source                    = "../../modules/CosmosDB"
  resourcegroupname         = var.resourcegroupname
  location                  = var.location
  iwalletcosmosdbaccount    = var.iwalletcosmosdbaccount
  iwalletcosmosdb           = var.iwalletcosmosdb
  iwalletcosmosdbcontainer1 = var.iwalletcosmosdbcontainer1
  leasepartitionkey         = var.leasepartitionkey
  iwalletcosmosdbcontainer2 = var.iwalletcosmosdbcontainer2
  walletpartitionkey        = var.walletpartitionkey

}

module "DataFactory" {

  depends_on        = [module.ResourceGroup]
  source            = "../../modules/DataFactory"
  resourcegroupname = var.resourcegroupname
  location          = var.location
  iwalletdfname     = var.iwalletdfname

}

module "StorageAccount" {

  depends_on         = [module.ResourceGroup]
  source             = "../../modules/StorageAccount"
  resourcegroupname  = var.resourcegroupname
  location           = var.location
  storageaccountname = var.storageaccountname
  containers_list    = var.containers_list

}

module "KeyVault" {

  depends_on        = [module.ResourceGroup]
  source            = "../../modules/KeyVault"
  resourcegroupname = var.resourcegroupname
  location          = var.location
  keyvaultname      = var.keyvaultname

}

module "ApplicationSecurityGroup" {

  depends_on        = [module.ResourceGroup]
  source            = "../../modules/ApplicationSecurityGroup"
  resourcegroupname = var.resourcegroupname
  location          = var.location
  iwalletasg      = var.iwalletasg

}