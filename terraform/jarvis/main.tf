module "ResourceGroup" {

  source            = "../../modules/ResourceGroup"
  resourcegroupname = var.resourcegroupname
  location          = var.location
  tags              = var.tags

}

module "FUNAPP_StorageAccount" {

  source            = "../../modules/StorageAccount"
  storage_list      = var.storage_list
  containers_list   = var.containers_list
  resourcegroupname = module.ResourceGroup.rg_name_out
  location          = var.location
  tags              = var.tags

}

module "FunctionApp" {

  depends_on = [
    module.ResourceGroup,
    module.FUNAPP_StorageAccount,
    module.ApplicationInsights,
    module.ApplicationServicePlan
  ]
  source                            = "../../modules/FunctionApp"
  resourcegroupname                 = module.ResourceGroup.rg_name_out
  location                          = var.location
  service_plan_id                   = module.ApplicationServicePlan.app_sp_out
  storageaccountname                = module.FUNAPP_StorageAccount.sa_name_out["hphcperfvastorage"]
  storage_account_access_key        = module.FUNAPP_StorageAccount.sa_primary_access_key_out["hphcperfvastorage"]
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

module "HPPC_AppService" {

  depends_on = [
    module.ResourceGroup,
    module.HPHC_ApplicationServicePlan
  ]
  source            = "../../modules/AppService"
  resourcegroupname = module.ResourceGroup.rg_name_out
  location          = var.location
  service_plan_id   = module.HPHC_ApplicationServicePlan.app_sp_out
  appservicename    = var.hphcappservicename
  stack_version     = var.hphc_stack_version
  app_settings      = var.app_settings
  tags              = var.tags

}


module "HPHC_ApplicationInsights" {

  source                  = "../../modules/ApplicationInsights"
  resourcegroupname       = module.ResourceGroup.rg_name_out
  location                = var.location
  applicationinsightsname = var.hphc_applicationinsightsname
  workspace_id            = null
  tags                    = var.tags

}


module "HPHC_ApplicationServicePlan" {

  depends_on = [
    module.ResourceGroup
  ]
  source            = "../../modules/ApplicationServicePlan"
  resourcegroupname = module.ResourceGroup.rg_name_out
  serviceplanname   = var.hphc_serviceplanname
  location          = var.location
  ostype            = var.ostype
  sku               = var.hphc_sku
  tags              = var.tags

}


module "NetworkSecurityGroup" {

  depends_on        = [
    module.ResourceGroup
  ]

  for_each          = var.nsgs
  source            = "./modules/NetworkSecurityGroup"
  location          = var.location
  resourcegroupname = var.resourcegroupname
  nsg_name          = each.value["nsg_name"]
  tags              = var.tags

  nsg_rules = lookup(each.value, "nsg_rules", [])

}


module "WindowsVirtualMachine" {

  depends_on        = [
    module.ResourceGroup
  ]

  for_each                   = var.vms
  source                     = "./modules/WindowsVirtualMachine"
  location                   = var.location
  resourcegroupname          = var.resourcegroupname
  subnet_resource_group_name = each.value["subnet_resource_group_name"]
  virtualmachine_name        = each.value["virtualmachine_name"]
  vm_size                    = each.value["vm_size"]
  virtual_network_name       = each.value["vm_vnet_name"]
  subnet_name                = each.value["vm_subnet_name"]

  vm_nic_name                   = each.value["vm_nic_name"]
  ip_config_name                = each.value["ip_config_name"]
  private_ip_address_allocation = lookup(each.value, "private_ip_address_allocation", "Dynamic")

  image_publisher = each.value["image_publisher"]
  image_offer     = each.value["image_offer"]
  image_sku       = each.value["image_sku"]
  image_version   = lookup(each.value, "image_version", "latest")

  osdisk_name     = each.value["osdisk_name"]
  osdisk_caching  = lookup(each.value, "osdisk_caching", "ReadWrite")
  os_disk_type    = each.value["osdisk_type"]
  os_disk_size_gb = each.value["os_disk_size_gb"]

  data_disks = lookup(each.value, "data_disks", [])

  computer_name  = lookup(each.value, "computer_name", "Virtual-Machine")
  admin_usename  = each.value["admin_usename"]
  admin_password = lookup(each.value, "admin_password", null)

  tags = var.tags

  #deleteDisks. This line to delete the OS disk and data disk automatically when deleting the VM if it's "true"
  delete_os_disk_on_termination    = lookup(each.value, "delete_os_disk_on_termination", true)
  delete_data_disks_on_termination = lookup(each.value, "delete_data_disks_on_termination", false)

}