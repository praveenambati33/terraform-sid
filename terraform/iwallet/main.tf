module "ResourceGroup" {

  source            = "../../modules/ResourceGroup"
  resourcegroupname = var.resourcegroupname
  location          = var.location
  tags              = var.tags

}


module "ApplicationInsights" {

  source                  = "../../modules/ApplicationInsights"
  resourcegroupname       = module.ResourceGroup.rg_name_out
  location                = var.location
  applicationinsightsname = var.applicationinsightsname
  workspace_id            = null
  tags                    = var.tags

}

module "NODE_ApplicationServicePlan" {

  depends_on = [
    module.ResourceGroup
  ]
  source            = "../../modules/ApplicationServicePlan"
  resourcegroupname = module.ResourceGroup.rg_name_out
  serviceplanname   = var.nodeserviceplanname
  location          = var.location
  ostype            = var.node_ostype
  sku               = var.node_sku
  tags              = var.tags

}

module "NODE_StorageAccount" {

  source            = "../../modules/StorageAccount"
  storage_list      = var.nodestorageaccountname
  containers_list   = var.fn_containers_list
  resourcegroupname = module.ResourceGroup.rg_name_out
  location          = var.location
  tags              = var.tags

}

module "NODE_FunctionApp" {

  depends_on = [
    module.ResourceGroup,
    module.NODE_StorageAccount,
    module.ApplicationInsights
  ]
  source                            = "../../modules/FunctionApp"
  resourcegroupname                 = module.ResourceGroup.rg_name_out
  location                          = var.location
  service_plan_id                   = module.JAVA_ApplicationServicePlan.app_sp_out
  storageaccountname                = module.NODE_StorageAccount.sa_name_out["eussit2fnappjs09stgacc"]
  storage_account_access_key        = module.NODE_StorageAccount.sa_primary_access_key_out["eussit2fnappjs09stgacc"]
  functionappname                   = var.nodefunctionappname
  stack_version                     = var.node_stack_version
  function_app_application_settings = var.node_function_app_application_settings
  application_insights_key          = module.ApplicationInsights.azurerm_application_insights_out
  tags                              = var.tags

}

module "KeyVault" {

  depends_on        = [module.ResourceGroup]
  source            = "../../modules/KeyVault"
  resourcegroupname = module.ResourceGroup.rg_name_out
  location          = var.location
  keyvaultname      = var.cosmoskeyvaultname
  tags              = var.tags
}


module "NODE_RecoveryServiceVault" {

  source            = "../../modules/RecoveryServiceVault"
  resourcegroupname = module.ResourceGroup.rg_name_out
  location          = var.location
  rsvname           = var.nodersvname
  rsvfspolicyname   = var.nodersvfspolicyname
  tags              = var.tags

}

module "JAVA_ApplicationServicePlan" {

  depends_on = [
    module.ResourceGroup
  ]
  source            = "../../modules/ApplicationServicePlan"
  resourcegroupname = module.ResourceGroup.rg_name_out
  serviceplanname   = var.javaserviceplanname
  location          = var.location
  ostype            = var.java_ostype
  sku               = var.java_sku
  tags              = var.tags

}

module "JAVA_StorageAccount" {

  source            = "../../modules/StorageAccount"
  storage_list      = var.javastorageaccountname
  containers_list   = var.fn_containers_list
  resourcegroupname = module.ResourceGroup.rg_name_out
  location          = var.location
  tags              = var.tags

}

module "JAVA_FunctionApp" {

  depends_on = [
    module.ResourceGroup,
    module.JAVA_StorageAccount,
    module.JAVA_ApplicationServicePlan
  ]
  source                            = "../../modules/FunctionApp"
  resourcegroupname                 = module.ResourceGroup.rg_name_out
  location                          = var.location
  service_plan_id                   = module.JAVA_ApplicationServicePlan.app_sp_out
  storageaccountname                = module.JAVA_StorageAccount.sa_name_out["eussit2fnappjava09stgacc"]
  storage_account_access_key        = module.JAVA_StorageAccount.sa_primary_access_key_out["eussit2fnappjava09stgacc"]
  functionappname                   = var.javafunctionappname
  stack_version                     = var.java_stack_version
  function_app_application_settings = var.java_function_app_application_settings
  application_insights_key          = module.ApplicationInsights.azurerm_application_insights_out
  tags                              = var.tags

}

module "JAVA_RecoveryServiceVault" {

  source            = "../../modules/RecoveryServiceVault"
  resourcegroupname = module.ResourceGroup.rg_name_out
  location          = var.location
  rsvname           = var.javarsvname
  rsvfspolicyname   = var.javarsvfspolicyname
  tags              = var.tags
}

module "App_KeyVault" {

  depends_on        = [module.ResourceGroup]
  source            = "../../modules/KeyVault"
  resourcegroupname = module.ResourceGroup.rg_name_out
  location          = var.location
  keyvaultname      = var.appkeyvaultname
  tags              = var.tags
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
  tags                      = var.tags

}

module "DataFactory" {

  depends_on        = [module.ResourceGroup]
  source            = "../../modules/DataFactory"
  resourcegroupname = var.resourcegroupname
  location          = var.location
  iwalletdfname     = var.iwalletdfname
  tags              = var.tags

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
  tags                       = var.tags

}

module "ApplicationSecurityGroup" {

  depends_on        = [module.ResourceGroup]
  source            = "../../modules/ApplicationSecurityGroup"
  resourcegroupname = var.resourcegroupname
  location          = var.location
  iwalletasg        = var.iwalletasg
  tags              = var.tags

}
