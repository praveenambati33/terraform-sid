#working code and modules

#Resource Group
module "CHub_ResourceGroup" {

  source                = "./modules/ResourceGroup"
  resource_group_name   = var.centralhub_resourcegroupname
  location              = var.location
  tags                  = var.tags

}

#Virtual Network
module "CHub_vnet" {

  depends_on            = [module.CHub_ResourceGroup]
  for_each              = var.vnets
  source                = "./modules/VirtualNetwork"
  location              = var.location
  resource_group_name   = var.centralhub_resourcegroupname
  vnet_name             = each.value["vnet_name"]
  address_space         = each.value["vnet_address_space"]
  tags                  = var.tags

}

#Subnet
module "CHub_subnet" {

  depends_on                = [module.CHub_vnet]
  for_each                  = var.subnets
  source                    = "./modules/Subnet"
  location                  = var.location
  resource_group_name       = var.centralhub_resourcegroupname
  virtual_network_name      = var.vnet_name
  subnet_name               = each.value["subnet_name"]
  subnet_address_prefixes   = each.value["subnet_address_prefixes"]
  tags                      = var.tags

  service_endpoints                               = lookup(each.value, "service_endpoints", [])
  service_endpoint_policy_ids                     = lookup(each.value, "service_endpoint_policy_ids", null)
  private_endpoint_network_policies_enabled       = lookup(each.value, "private_endpoint_network_policies_enabled", null)
  private_link_service_network_policies_enabled   = lookup(each.value, "private_link_service_network_policies_enabled", null)

  delegation_settings = lookup(each.value, "delegation_settings", [])

}

#NSG
module "CHub_nsg" {

  depends_on            = [module.CHub_ResourceGroup]
  for_each              = var.nsgs
  source                = "./modules/NetworkSecurityGroup"
  location              = var.location
  resource_group_name   = var.centralhub_resourcegroupname
  nsg_name              = each.value["nsg_name"]
  tags                  = var.tags

  nsg_rules             = lookup(each.value, "nsg_rules", [])

}

#########################################################################################################################################

#########################################################################################################################################

#Resource Group
module "virtualmachine_rg_ResourceGroup" {

  source                = "./modules/ResourceGroup"
  resource_group_name   = var.centralhub_virtualmachine_rg
  location              = var.location
  tags                  = var.tags

}

#virtualmachine_rg NSG
module "virtualmachine_rg_nsg" {

  depends_on            = [module.virtualmachine_rg_ResourceGroup]
  for_each              = var.virtualmachine_rg_nsgs
  source                = "./modules/NetworkSecurityGroup"
  location              = var.location
  resource_group_name   = var.centralhub_virtualmachine_rg
  nsg_name              = each.value["nsg_name"]
  tags                  = var.tags

  nsg_rules             = lookup(each.value, "nsg_rules", [])

}

