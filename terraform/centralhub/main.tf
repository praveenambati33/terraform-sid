#Resource Group
module "CHub_ResourceGroup" {

  source              = "./modules/ResourceGroup"
  resource_group_name = var.centralhub_resourcegroupname
  location            = var.location
  tags                = var.tags

}

#keyvault
module "CHub_KeyVault" {

  depends_on        = [module.CHub_ResourceGroup]
  source            = "./modules/KeyVault"
  resourcegroupname = var.centralhub_resourcegroupname
  location          = var.location
  keyvaultname      = var.centralhub_keyvaultname
  tags              = var.tags
}

#Virtual Network
module "CHub_vnet" {

  depends_on          = [module.CHub_ResourceGroup]
  for_each            = var.vnets
  source              = "./modules/VirtualNetwork"
  location            = var.location
  resource_group_name = var.centralhub_resourcegroupname
  vnet_name           = each.value["vnet_name"]
  address_space       = each.value["vnet_address_space"]
  tags                = var.tags

}

#Subnet
module "CHub_subnet" {

  depends_on              = [module.CHub_vnet]
  for_each                = var.subnets
  source                  = "./modules/Subnet"
  location                = var.location
  resource_group_name     = var.centralhub_resourcegroupname
  virtual_network_name    = var.vnet_name
  subnet_name             = each.value["subnet_name"]
  subnet_address_prefixes = each.value["subnet_address_prefixes"]
  tags                    = var.tags

  service_endpoints                             = lookup(each.value, "service_endpoints", [])
  service_endpoint_policy_ids                   = lookup(each.value, "service_endpoint_policy_ids", null)
  private_endpoint_network_policies_enabled     = lookup(each.value, "private_endpoint_network_policies_enabled", null)
  private_link_service_network_policies_enabled = lookup(each.value, "private_link_service_network_policies_enabled", null)

  delegation_settings = lookup(each.value, "delegation_settings", [])

}

#NSG
module "CHub_nsg" {

  depends_on          = [module.CHub_ResourceGroup]
  for_each            = var.nsgs
  source              = "./modules/NetworkSecurityGroup"
  location            = var.location
  resource_group_name = var.centralhub_resourcegroupname
  nsg_name            = each.value["nsg_name"]
  tags                = var.tags

  nsg_rules = lookup(each.value, "nsg_rules", [])

}

#Public IP Address
module "CHub_PublicIP" {

  depends_on         = [module.CHub_ResourceGroup]
  for_each           = var.publicIps
  source             = "./modules/PublicIP"
  resourcegroupname  = var.centralhub_resourcegroupname
  location           = var.location
  public_ip_name     = each.value["public_ip_name"]
  allocation_method  = lookup(each.value, "allocation_method", "Static")
  public_ip_sku      = lookup(each.value, "public_ip_sku", "Basic")
  public_ip_sku_tier = lookup(each.value, "public_ip_sku_tier", "Regional")
  tags               = var.tags

}


#RSV
resource "azurerm_recovery_services_vault" "rsv" {

  depends_on          = [module.CHub_VM]
  name                = var.rsv_name
  location            = var.location
  resource_group_name = var.centralhub_resourcegroupname
  sku                 = var.rsv_sku

  soft_delete_enabled = true
  tags                = var.tags

}

resource "azurerm_backup_policy_vm" "WeeklyPolicy" {

  depends_on                     = [azurerm_recovery_services_vault.rsv]
  name                           = "WeeklyPolicy"
  resource_group_name            = var.centralhub_resourcegroupname
  recovery_vault_name            = var.rsv_name
  instant_restore_retention_days = 5

  timezone = "UTC"

  backup {
    frequency = "Weekly"
    time      = "02:00"
    weekdays  = ["Sunday"]
  }

  retention_weekly {
    count    = 6
    weekdays = ["Sunday"]
  }

}

data "azurerm_virtual_machine" "backup_vm" {

  depends_on          = [module.CHub_VM]
  name                = "eus-hub-central-dns-vm-01"
  resource_group_name = var.centralhub_resourcegroupname

}

resource "azurerm_backup_protected_vm" "backup_vm_policy01" {

  depends_on          = [azurerm_recovery_services_vault.rsv]
  resource_group_name = var.centralhub_resourcegroupname
  recovery_vault_name = var.rsv_name
  source_vm_id        = data.azurerm_virtual_machine.backup_vm.id
  backup_policy_id    = azurerm_backup_policy_vm.WeeklyPolicy.id

}

#LAW
module "LogAnalyticsWorkspace" {

  depends_on        = [module.CHub_ResourceGroup]
  source            = "./modules/LogAnalyticsWorkspace"
  resourcegroupname = var.centralhub_resourcegroupname
  location          = var.location
  lawworkspacename  = var.lawworkspacename
  tags              = var.tags

}

data "azurerm_log_analytics_workspace" "LAW" {

  depends_on          = [module.LogAnalyticsWorkspace]
  name                = var.lawworkspacename
  resource_group_name = var.centralhub_resourcegroupname

}

#LAW Solution
resource "azurerm_log_analytics_solution" "example" {

  depends_on            = [data.azurerm_log_analytics_workspace.LAW]
  solution_name         = var.law_solution_name
  location              = var.location
  resource_group_name   = var.centralhub_resourcegroupname
  workspace_resource_id = data.azurerm_log_analytics_workspace.LAW.id
  workspace_name        = var.lawworkspacename
  tags                  = var.tags

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/NetworkMonitoring"
  }

}

#Storage Account
module "CHub_StorageAccount01" {

  depends_on        = [module.CHub_ResourceGroup]
  source            = "./modules/StorageAccount"
  storage_list      = var.storageaccount_01
  containers_list   = var.containers_list01
  resourcegroupname = var.centralhub_resourcegroupname
  location          = var.location
  tags              = var.tags

}

module "CHub_StorageAccount02" {

  depends_on        = [module.CHub_ResourceGroup]
  source            = "./modules/StorageAccount"
  storage_list      = var.storageaccount_02
  containers_list   = var.containers_list02
  resourcegroupname = var.centralhub_resourcegroupname
  location          = var.location
  tags              = var.tags

}

#Private DNS Zone
resource "azurerm_private_dns_zone" "private_dns_zone" {

  depends_on          = [module.CHub_ResourceGroup]
  name                = var.private_dns_zone_name
  resource_group_name = var.centralhub_resourcegroupname
  tags                = var.tags

}

data "azurerm_virtual_network" "zone_vnet" {

  depends_on          = [module.CHub_vnet]
  name                = "eus-hub-central-vnet-01"
  resource_group_name = var.centralhub_resourcegroupname

}

resource "azurerm_private_dns_zone_virtual_network_link" "dnszone_link" {

  depends_on            = [azurerm_private_dns_zone.private_dns_zone]
  name                  = "isdhtf46fd5pg"
  resource_group_name   = var.centralhub_resourcegroupname
  private_dns_zone_name = "privatelink.servicebus.windows.net"
  virtual_network_id    = data.azurerm_virtual_network.zone_vnet.id

}

#Private DNS A record
resource "azurerm_private_dns_a_record" "private_dns_a_record_1" {

  depends_on          = [azurerm_private_dns_zone.private_dns_zone]
  name                = var.private_dns_a_record_01
  zone_name           = azurerm_private_dns_zone.private_dns_zone.name
  resource_group_name = var.centralhub_resourcegroupname
  ttl                 = 10
  records             = ["172.30.255.100"]

}

resource "azurerm_private_dns_a_record" "private_dns_a_record_2" {

  depends_on          = [azurerm_private_dns_zone.private_dns_zone]
  name                = var.private_dns_a_record_02
  zone_name           = azurerm_private_dns_zone.private_dns_zone.name
  resource_group_name = var.centralhub_resourcegroupname
  ttl                 = 10
  records             = ["172.30.254.68"]

}

#Route Table
resource "azurerm_route_table" "route_table" {

  depends_on                    = [module.CHub_ResourceGroup]
  name                          = var.route_table_name
  location                      = var.location
  resource_group_name           = var.centralhub_resourcegroupname
  disable_bgp_route_propagation = false

  route {
    name                   = "eus-onprem-2-firewall-for-simplifyDEVspoke-route"
    address_prefix         = "172.29.4.0/25"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "172.30.255.4"
  }
  route {
    name                   = "onprem-2-firewall-datycsdev-spoke-route"
    address_prefix         = "172.29.6.0/26"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "172.30.255.4"
  }
  route {
    name                   = "onprem-2-firewall-datycsprod-spoke-route"
    address_prefix         = "172.29.131.192/26"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "172.30.255.4"
  }
  route {
    name                   = "eus-onprem-2-firewall-for-simplifySITspoke-route"
    address_prefix         = "172.29.4.128/25"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "172.30.255.4"
  }
  route {
    name                   = "eus-onprem-2-sentinaldev01VNet-spoke"
    address_prefix         = "172.29.0.0/24"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "172.30.255.4"
  }
  route {
    name                   = "eus-onprem-2-firewall-for-simplifyProdspoke-route"
    address_prefix         = "172.29.129.128/25"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "172.30.255.4"
  }
  route {
    name                   = "eus-onprem-2-sentinelprod01VNet-spoke"
    address_prefix         = "172.29.2.0/24"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "172.30.255.4"
  }
  route {
    name                   = "eus-onprem-2-teradata-spoke"
    address_prefix         = "172.29.132.0/22"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "172.30.255.4"
  }

  tags = var.tags
}

data "azurerm_subnet" "route_table_subnet" {

  depends_on           = [module.CHub_subnet]
  name                 = "GatewaySubnet"
  virtual_network_name = "eus-hub-central-vnet-01"
  resource_group_name  = var.centralhub_resourcegroupname

}

resource "azurerm_subnet_route_table_association" "route_table_subnet_association" {

  depends_on = [
    azurerm_route_table.route_table,
    module.CHub_subnet,
    data.azurerm_subnet.route_table_subnet
  ]
  subnet_id      = data.azurerm_subnet.route_table_subnet.id
  route_table_id = azurerm_route_table.route_table.id

}

data "azurerm_public_ip" "virtual_network_gateway_publicIp" {

  depends_on          = [module.CHub_PublicIP]
  name                = "eus-hub-central-pip-vng-01"
  resource_group_name = var.centralhub_resourcegroupname

}

#Local Network Gateway
resource "azurerm_local_network_gateway" "local_network_gateway" {

  depends_on          = [module.CHub_ResourceGroup]
  name                = var.local_network_gateway_name
  location            = var.location
  resource_group_name = var.centralhub_resourcegroupname
  gateway_address     = "155.49.241.10"
  address_space       = ["10.0.0.0/8", "155.49.0.0/16", "172.16.32.0/24", "192.168.115.0/24", "192.168.127.0/24"]
  tags                = var.tags

}

#Virtual Network Gateway
resource "azurerm_virtual_network_gateway" "virtual_network_gateway" {

  depends_on = [
    module.CHub_ResourceGroup,
    data.azurerm_public_ip.virtual_network_gateway_publicIp,
    data.azurerm_subnet.route_table_subnet
  ]
  name                = var.virtual_network_gateway_name
  location            = var.location
  resource_group_name = var.centralhub_resourcegroupname

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "VpnGw2"

  ip_configuration {
    name                          = "default"
    public_ip_address_id          = data.azurerm_public_ip.virtual_network_gateway_publicIp.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = data.azurerm_subnet.route_table_subnet.id
  }
  tags = var.tags

}

resource "azurerm_virtual_network_gateway_connection" "virtual_network_gateway_connection" {

  depends_on = [
    azurerm_virtual_network_gateway.virtual_network_gateway,
    azurerm_local_network_gateway.local_network_gateway,
  ]
  name                = var.virtual_network_gateway_connection_name
  location            = var.location
  resource_group_name = var.centralhub_resourcegroupname

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.virtual_network_gateway.id
  local_network_gateway_id   = azurerm_local_network_gateway.local_network_gateway.id

  shared_key = "D/sHZpxAz4Xd7vjC5rOyth+joWD+RXcn"
  tags       = var.tags

}

data "azurerm_subnet" "bastion_subnet" {

  depends_on           = [module.CHub_subnet]
  name                 = "AzureBastionSubnet"
  virtual_network_name = "eus-hub-central-vnet-01"
  resource_group_name  = var.centralhub_resourcegroupname

}

data "azurerm_public_ip" "bastion_publicIp" {

  depends_on          = [module.CHub_PublicIP]
  name                = "eus-hub-central-vnet-01-pip"
  resource_group_name = var.centralhub_resourcegroupname

}

#Bastion
resource "azurerm_bastion_host" "bastion" {

  depends_on = [
    module.CHub_ResourceGroup,
    data.azurerm_public_ip.bastion_publicIp,
    data.azurerm_subnet.bastion_subnet
  ]
  name                = var.bastion_name
  location            = var.location
  resource_group_name = var.centralhub_resourcegroupname
  tags                = var.tags

  ip_configuration {
    name                 = "IpConf"
    subnet_id            = data.azurerm_subnet.bastion_subnet.id
    public_ip_address_id = data.azurerm_public_ip.bastion_publicIp.id
  }

}

#Event Hub
module "EventHub" {

  depends_on                 = [module.CHub_ResourceGroup]
  source                     = "./modules/EventHub"
  resourcegroupname          = var.centralhub_resourcegroupname
  location                   = var.location
  eventhubs                  = var.eventhubs
  iwalletensname             = var.eventhub_namespace_name
  eventhubstorageaccountname = var.eventhubstorageaccountname
  eventhubcontainers_list    = var.eventhubcontainers_list
  tags                       = var.tags

}

#########################################################################################################################################

#########################################################################################################################################

#Resource Group
module "virtualmachine_rg_ResourceGroup" {

  source              = "./modules/ResourceGroup"
  resource_group_name = var.centralhub_virtualmachine_rg
  location            = var.location
  tags                = var.tags

}

#virtualmachine_rg NSG
module "virtualmachine_rg_nsg" {

  depends_on          = [module.virtualmachine_rg_ResourceGroup]
  for_each            = var.virtualmachine_rg_nsgs
  source              = "./modules/NetworkSecurityGroup"
  location            = var.location
  resource_group_name = var.centralhub_virtualmachine_rg
  nsg_name            = each.value["nsg_name"]
  tags                = var.tags

  nsg_rules = lookup(each.value, "nsg_rules", [])

}

