module "ResourceGroup" {

  source            = "../../modules/ResourceGroup"
  resourcegroupname = var.resourcegroupname
  location          = var.location
  tags              = var.tags

}

module "FUNAPP_StorageAccount" {

  source            = "../../modules/StorageAccount"
  storage_list      = var.storageaccountname
  containers_list   = var.fun_containers_list
  resourcegroupname = module.ResourceGroup.rg_name_out
  location          = var.location
  tags              = var.tags

}

module "StorageAccount" {

  source            = "../../modules/StorageAccount"
  storage_list      = var.storageaccountlogsname
  containers_list   = var.logs_containers_list
  resourcegroupname = module.ResourceGroup.rg_name_out
  location          = var.location
  tags              = var.tags

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
  service_plan_id                   = data.azurerm_service_plan.shared-appservice-plan.id
  storageaccountname                = module.FUNAPP_StorageAccount.sa_name_out
  storage_account_access_key        = module.FUNAPP_StorageAccount.sa_primary_access_key_out
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


module "KeyVault" {

  depends_on        = [module.ResourceGroup]
  source            = "../../modules/KeyVault"
  resourcegroupname = module.ResourceGroup.rg_name_out
  location          = var.location
  keyvaultname      = var.keyvaultname
  tags              = var.tags
}

data "azurerm_service_plan" "shared-appservice-plan" {

  name                = "eus-perf-shared-asp-01"
  resource_group_name = "eus-perf-shared-asp-rg"

}
