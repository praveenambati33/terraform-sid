module "ResourceGroup" {

  source            = "../../modules/ResourceGroup"
  resourcegroupname = var.resourcegroupname
  location          = var.location
  tags              = var.tags

}

module "ASP-SHARED-ResourceGroup" {

  source            = "../../modules/ResourceGroup"
  resourcegroupname = var.asp-resourcegroupname
  location          = var.location
  tags              = var.tags

}

module "ApplicationServicePlan" {

  depends_on = [
    module.ASP-SHARED-ResourceGroup
  ]
  source            = "../../modules/ApplicationServicePlan"
  resourcegroupname = module.ASP-SHARED-ResourceGroup.rg_name_out
  serviceplanname   = var.serviceplanname
  location          = var.location
  ostype            = var.ostype
  sku               = var.sku
  tags              = var.tags
}

module "StorageAccount" {

  source             = "../../modules/StorageAccount_tmp"
  storageaccountname = var.storageaccountlogsname
  resourcegroupname  = module.ResourceGroup.rg_name_out
  location           = var.location
  tags               = var.tags
}


module "NODE_FUNAPP_StorageAccount" {

  source             = "../../modules/StorageAccount_tmp"
  storageaccountname = var.storageaccountname
  resourcegroupname  = module.ResourceGroup.rg_name_out
  location           = var.location
  tags               = var.tags

}


module "FunctionApp" {

  depends_on = [
    module.ResourceGroup,
    module.NODE_FUNAPP_StorageAccount,
    module.ApplicationServicePlan,
    module.ApplicationInsights
  ]
  source                            = "../../modules/FunctionApp/mrf"
  resourcegroupname                 = module.ResourceGroup.rg_name_out
  location                          = var.location
  service_plan_id                   = module.ApplicationServicePlan.app_sp_out
  storageaccountname                = module.NODE_FUNAPP_StorageAccount.sa_name_out
  storage_account_access_key        = module.NODE_FUNAPP_StorageAccount.sa_primary_access_key_out
  functionappname                   = var.functionappname
  stack_version                     = var.stack_version
  function_app_application_settings = var.function_app_application_settings
  application_insights_key          = module.ApplicationInsights.azurerm_application_insights_out
  tags                              = var.tags

}

module "LogAnalyticsWorkspace" {

  source            = "../../modules/LogAnalyticsWorkspace"
  resourcegroupname = module.ResourceGroup.rg_name_out
  location          = var.location
  lawworkspacename  = var.lawworkspacename
  tags              = var.tags

}

module "ApplicationInsights" {

  depends_on = [
    module.LogAnalyticsWorkspace
  ]
  source                  = "../../modules/ApplicationInsights"
  resourcegroupname       = module.ResourceGroup.rg_name_out
  location                = var.location
  applicationinsightsname = var.applicationinsightsname
  workspace_id            = module.LogAnalyticsWorkspace.azurerm_log_analytics_workspace_output
  tags                    = var.tags

}