module "ResourceGroup" {

  source            = "../../modules/ResourceGroup"
  resourcegroupname = var.resourcegroupname
  location          = var.location
  tags              = var.tags

}

module "FUNAPP_StorageAccount" {

  source             = "../../modules/StorageAccount"
  storage_list = var.storage_list
  containers_list    = var.containers_list
  resourcegroupname  = module.ResourceGroup.rg_name_out
  location           = var.location
  tags               = var.tags

}

module "FunctionApp" {

  depends_on = [
    module.ResourceGroup,
    module.FUNAPP_StorageAccount,
    module.ApplicationInsights
  ]
  source                            = "../../modules/FunctionApp"
  resourcegroupname                 = module.ResourceGroup.rg_name_out
  location                          = var.location
  service_plan_id                   = module.ApplicationServicePlan.app_sp_out
  storageaccountname                = module.FUNAPP_StorageAccount.sa_name_out
  storage_account_access_key        = module.FUNAPP_StorageAccount.sa_primary_access_key_out
  functionappname                   = var.functionappname
  stack_version                     = var.stack_version
  function_app_application_settings = var.function_app_application_settings
  application_insights_key          = module.ApplicationInsights.azurerm_application_insights_out
  tags                              = var.tags

}


module "ApplicationServicePlan" {

  depends_on = [
    module.ResourceGroup
  ]
  source            = "../../modules/ApplicationServicePlan"
  resourcegroupname = module.ResourceGroup.rg_name_out
  serviceplanname   = var.serviceplanname
  location          = var.location
  ostype            = var.ostype
  sku               = var.sku
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


module "KeyVault" {

  depends_on        = [module.ResourceGroup]
  source            = "../../modules/KeyVault"
  resourcegroupname = module.ResourceGroup.rg_name_out
  location          = var.location
  keyvaultname      = var.keyvaultname
  tags              = var.tags
}