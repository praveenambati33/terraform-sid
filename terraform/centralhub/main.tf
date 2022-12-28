#Central Hub Central RG Code

#Resource Group
module "CHub_ResourceGroup" {

  source            = "../../modules/ResourceGroup"
  resourcegroupname = var.centralhub_resourcegroupname
  location          = var.location
  tags              = var.tags

}

#keyvault
module "CHub_KeyVault" {

  depends_on        = [module.CHub_ResourceGroup]
  source            = "../../modules/KeyVault"
  resourcegroupname = var.centralhub_resourcegroupname
  location          = var.location
  keyvaultname      = var.centralhub_keyvaultname
  tags              = var.tags
}

#Virtual Network
module "CHub_vnet" {

  depends_on        = [module.CHub_ResourceGroup]
  for_each          = var.vnets
  source            = "../../modules/VirtualNetwork"
  location          = var.location
  resourcegroupname = var.centralhub_resourcegroupname
  vnet_name         = each.value["vnet_name"]
  address_space     = each.value["vnet_address_space"]
  tags              = var.tags

}

#Subnet
module "CHub_subnet" {

  depends_on              = [module.CHub_vnet]
  for_each                = var.subnets
  source                  = "../../modules/Subnet"
  location                = var.location
  resourcegroupname       = var.centralhub_resourcegroupname
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

  depends_on        = [module.CHub_ResourceGroup]
  for_each          = var.nsgs
  source            = "../../modules/NetworkSecurityGroup"
  location          = var.location
  resourcegroupname = var.centralhub_resourcegroupname
  nsg_name          = each.value["nsg_name"]
  tags              = var.tags

  nsg_rules = lookup(each.value, "nsg_rules", [])

}

#Public IP Address
module "CHub_PublicIP" {

  depends_on         = [module.CHub_ResourceGroup]
  for_each           = var.publicIps
  source             = "../../modules/PublicIP"
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
  source            = "../../modules/LogAnalyticsWorkspace"
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
resource "azurerm_log_analytics_solution" "LAW_solution" {

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
  source            = "../../modules/StorageAccount"
  storage_list      = var.storageaccount_01
  containers_list   = var.containers_list01
  resourcegroupname = var.centralhub_resourcegroupname
  location          = var.location
  tags              = var.tags

}

module "CHub_StorageAccount02" {

  depends_on        = [module.CHub_ResourceGroup]
  source            = "../../modules/StorageAccount"
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
  source                     = "../../modules/EventHub"
  resourcegroupname          = var.centralhub_resourcegroupname
  location                   = var.location
  eventhubs                  = var.eventhubs
  iwalletensname             = var.eventhub_namespace_name
  eventhubstorageaccountname = var.eventhubstorageaccountname
  eventhubcontainers_list    = var.eventhubcontainers_list
  tags                       = var.tags

}

########################################################################################################################################################

########################################################################################################################################################

#Virtual Machine RG Code

#Resource Group
module "virtualmachine_rg_ResourceGroup" {

  source            = "../../modules/ResourceGroup"
  resourcegroupname = var.centralhub_virtualmachine_rg
  location          = var.location
  tags              = var.tags

}

#virtualmachine_rg NSG
module "virtualmachine_rg_nsg" {

  depends_on        = [module.virtualmachine_rg_ResourceGroup]
  for_each          = var.virtualmachine_rg_nsgs
  source            = "../../modules/NetworkSecurityGroup"
  location          = var.location
  resourcegroupname = var.centralhub_virtualmachine_rg
  nsg_name          = each.value["nsg_name"]
  tags              = var.tags

  nsg_rules = lookup(each.value, "nsg_rules", [])

}

#############################################################################################################################################################

#############################################################################################################################################################

#Central Hub Prod RG Code

#Resource Group
module "Centralhub_Prod_rg" {

  source            = "../../modules/ResourceGroup"
  resourcegroupname = var.centralhub_prod_rg
  location          = var.location
  tags              = var.tags

}

#centralhub_prod_rg NSG
module "Centralhub_Prod_nsg" {

  depends_on        = [module.Centralhub_Prod_rg]
  for_each          = var.centralhub_prod_nsgs
  source            = "../../modules/NetworkSecurityGroup"
  location          = var.location
  resourcegroupname = var.centralhub_prod_rg
  nsg_name          = each.value["nsg_name"]
  tags              = var.tags

  nsg_rules = lookup(each.value, "nsg_rules", [])

}

#Storage Account
module "Centralhub_Prod_StorageAccount" {

  depends_on        = [module.Centralhub_Prod_rg]
  source            = "../../modules/StorageAccount"
  storage_list      = var.centralhub_prod_storageaccount
  containers_list   = var.centralhub_prod_containers_list
  resourcegroupname = var.centralhub_prod_rg
  location          = var.location
  tags              = var.tags

}

#Public IP Address
module "Centralhub_Prod_PublicIP" {

  depends_on         = [module.Centralhub_Prod_rg]
  for_each           = var.centralhub_prod_publicIps
  source             = "../../modules/PublicIP"
  resourcegroupname  = var.centralhub_prod_rg
  location           = var.location
  public_ip_name     = each.value["public_ip_name"]
  allocation_method  = lookup(each.value, "allocation_method", "Static")
  public_ip_sku      = lookup(each.value, "public_ip_sku", "Basic")
  public_ip_sku_tier = lookup(each.value, "public_ip_sku_tier", "Regional")
  tags               = var.tags

}

#Application Insight
module "Centralhub_Prod_ApplicationInsights" {

  depends_on = [
    module.Centralhub_Prod_rg,
    module.LogAnalyticsWorkspace
  ]
  source                  = "../../modules/ApplicationInsights"
  resourcegroupname       = var.centralhub_prod_rg
  location                = var.location
  applicationinsightsname = var.centralhub_prod_applicationinsightsname
  workspace_id            = module.LogAnalyticsWorkspace.azurerm_log_analytics_workspace_output
  tags                    = var.tags

}

#Service Bus Namespace
resource "azurerm_servicebus_namespace" "centralhub_prod_servicebus_namespace" {

  depends_on          = [module.Centralhub_Prod_rg]
  name                = var.centralhub_prod_servicebus_namespace_name
  location            = var.location
  resource_group_name = var.centralhub_prod_rg
  sku                 = "Premium"
  capacity            = 1
  tags                = var.tags

}

resource "azurerm_servicebus_namespace_authorization_rule" "centralhub_prod_servicebus_namespace_authorization_rule_01" {

  depends_on   = [azurerm_servicebus_namespace.centralhub_prod_servicebus_namespace]
  name         = "relay-policy"
  namespace_id = azurerm_servicebus_namespace.centralhub_prod_servicebus_namespace.id
  listen       = true
  send         = true
  manage       = true

}
resource "azurerm_servicebus_namespace_authorization_rule" "centralhub_prod_servicebus_namespace_authorization_rule_02" {

  depends_on   = [azurerm_servicebus_namespace.centralhub_prod_servicebus_namespace]
  name         = "RootManageSharedAccessKey"
  namespace_id = azurerm_servicebus_namespace.centralhub_prod_servicebus_namespace.id
  listen       = true
  send         = true
  manage       = true

}
resource "azurerm_servicebus_namespace_authorization_rule" "centralhub_prod_servicebus_namespace_authorization_rule_03" {

  depends_on   = [azurerm_servicebus_namespace.centralhub_prod_servicebus_namespace]
  name         = "SimplifySASKey"
  namespace_id = azurerm_servicebus_namespace.centralhub_prod_servicebus_namespace.id
  listen       = true
  send         = true
  manage       = true

}

resource "azurerm_servicebus_namespace_network_rule_set" "centralhub_prod_servicebus_namespace_network_rule_set" {

  depends_on                    = [azurerm_servicebus_namespace.centralhub_prod_servicebus_namespace]
  namespace_id                  = azurerm_servicebus_namespace.centralhub_prod_servicebus_namespace.id
  default_action                = "Deny"
  public_network_access_enabled = true
  ip_rules                      = ["155.49.0.0/16", "52.146.56.211", "136.226.75.115", "136.226.50.0/23", "165.225.220.0/23", "20.119.16.10"]

}

#API Management Service
resource "azurerm_api_management" "centralhub_prod_api_management_service" {

  depends_on                = [module.Centralhub_Prod_rg]
  name                      = var.centralhub_prod_api_management_service_name
  location                  = var.location
  resource_group_name       = var.centralhub_prod_rg
  publisher_name            = "HPHC"
  publisher_email           = "hemant_kohli@harvardpilgrim.org"
  notification_sender_email = "apimgmt-noreply@mail.windowsazure.com"
  sku_name                  = "Developer_1"

}

data "azurerm_subnet" "centralhub_prod_application_gateway_subnet" {

  depends_on           = [module.CHub_subnet]
  name                 = "eus-prod-snet-agw-01"
  virtual_network_name = "eus-hub-central-vnet-01"
  resource_group_name  = var.centralhub_resourcegroupname

}

data "azurerm_public_ip" "centralhub_prod_application_gateway_publicIp" {

  depends_on          = [module.Centralhub_Prod_PublicIP]
  name                = "eus-hub-central-prod-agw-pip-01"
  resource_group_name = var.centralhub_prod_rg

}

#Application Gateway
resource "azurerm_application_gateway" "centralhub_prod_application_gateway" {

  depends_on = [
    module.Centralhub_Prod_rg,
    data.azurerm_subnet.centralhub_prod_application_gateway_subnet,
    data.azurerm_public_ip.centralhub_prod_application_gateway_publicIp
  ]
  name                = var.centralhub_prod_applicationgateway_name
  resource_group_name = var.centralhub_prod_rg
  location            = var.location
  tags                = var.tags

  sku {
    name     = "WAF_Medium"
    tier     = "WAF"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = data.azurerm_subnet.centralhub_prod_application_gateway_subnet.id
  }

  frontend_port {
    name = "port_443"
    port = 443
  }
  frontend_port {
    name = "port_8083"
    port = 8083
  }
  frontend_port {
    name = "port_8084"
    port = 8084
  }
  frontend_port {
    name = "port_80"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "appGwPublicFrontendIp"
    public_ip_address_id = data.azurerm_public_ip.centralhub_prod_application_gateway_publicIp.id
  }

  #NOTE: Need to provide Cert for "HTTPS" listeners. Need to provide all the details for cert.
  http_listener {
    name                           = "apigw-p-listener"
    frontend_ip_configuration_name = "appGwPublicFrontendIp"
    frontend_port_name             = "port_443"
    protocol                       = "Https"
    host_name                      = "apigw.harvardpilgrim.org"
    ssl_certificate_name           = "appgwcertprod_pfx"
  }
  http_listener {
    name                           = "digitalicon-p-listener"
    frontend_ip_configuration_name = "appGwPublicFrontendIp"
    frontend_port_name             = "port_443"
    protocol                       = "Https"
    host_name                      = "icons.point32health.org"
    ssl_certificate_name           = "icons.point32health.org-pfx"
  }
  http_listener {
    name                           = "digitalicon-p-http-listner"
    frontend_ip_configuration_name = "appGwPublicFrontendIp"
    frontend_port_name             = "port_80"
    protocol                       = "Http"
    host_name                      = "icons.point32health.org"
  }

  backend_address_pool {
    name         = "apimbackend"
    ip_addresses = ["172.30.254.117"]
  }
  backend_address_pool {
    name         = "digital-icon-prod-vm"
    ip_addresses = ["172.29.167.196"]
  }

  backend_http_settings {
    name                  = "apimsetting"
    cookie_based_affinity = "Disabled"
    affinity_cookie_name  = "ApplicationGatewayAffinity"
    port                  = 443
    protocol              = "Https"
    request_timeout       = 180
    host_name             = "apigw.harvardpilgrim.org"
    probe_name            = "apimprobe"
  }
  backend_http_settings {
    name                  = "digital-icon-httpsetting"
    cookie_based_affinity = "Disabled"
    affinity_cookie_name  = "ApplicationGatewayAffinity"
    port                  = 443
    protocol              = "Https"
    request_timeout       = 60
    host_name             = "icons.point32health.org"
    probe_name            = "digitalicon-probe"
  }

  redirect_configuration {
    name                 = "digitalicon-p-http-rule"
    redirect_type        = "Permanent"
    target_listener_name = "digitalicon-p-listener"
    include_path         = true
    include_query_string = true
  }

  request_routing_rule {
    name                       = "apigw-p-rule"
    rule_type                  = "PathBasedRouting"
    http_listener_name         = "apigw-p-listener"
    backend_http_settings_name = "apimsetting"
  }
  request_routing_rule {
    name                        = "digitalicon-p-http-rule"
    rule_type                   = "Basic"
    http_listener_name          = "digitalicon-p-http-listner"
    redirect_configuration_name = "digitalicon-p-http-rule"
  }
  request_routing_rule {
    name                       = "digital-p-https-rule"
    rule_type                  = "Basic"
    http_listener_name         = "digitalicon-p-listener"
    backend_address_pool_name  = "digital-icon-prod-vm"
    backend_http_settings_name = "digital-icon-httpsetting"
  }

  probe {
    name                = "apimprobe"
    protocol            = "Https"
    host                = "apigw.harvardpilgrim.org"
    path                = "/status-0123456789abcdef"
    interval            = 30
    timeout             = 120
    unhealthy_threshold = 8
  }
  probe {
    name                = "digitalicon-probe"
    protocol            = "Https"
    host                = "icons.point32health.org"
    path                = "/status-0123456789abcdef"
    interval            = 30
    timeout             = 120
    unhealthy_threshold = 3
  }

}


####################################################################################################################################################################

####################################################################################################################################################################

#Central Hub Sit RG Code

#Resource Group
module "Centralhub_Sit_rg" {

  source            = "../../modules/ResourceGroup"
  resourcegroupname = var.centralhub_sit_rg
  location          = var.location
  tags              = var.tags

}

#centralhub_sit_rg NSG
module "Centralhub_Sit_nsg" {

  depends_on        = [module.Centralhub_Sit_rg]
  for_each          = var.centralhub_sit_nsgs
  source            = "../../modules/NetworkSecurityGroup"
  location          = var.location
  resourcegroupname = var.centralhub_sit_rg
  nsg_name          = each.value["nsg_name"]
  tags              = var.tags

  nsg_rules = lookup(each.value, "nsg_rules", [])

}

#Storage Account
module "Centralhub_Sit_StorageAccount" {

  depends_on        = [module.Centralhub_Sit_rg]
  source            = "../../modules/StorageAccount"
  storage_list      = var.centralhub_sit_storageaccount
  containers_list   = var.centralhub_sit_containers_list
  resourcegroupname = var.centralhub_sit_rg
  location          = var.location
  tags              = var.tags

}

#Public IP Address
module "Centralhub_Sit_PublicIP" {

  depends_on         = [module.Centralhub_Sit_rg]
  for_each           = var.centralhub_sit_publicIps
  source             = "../../modules/PublicIP"
  resourcegroupname  = var.centralhub_sit_rg
  location           = var.location
  public_ip_name     = each.value["public_ip_name"]
  allocation_method  = lookup(each.value, "allocation_method", "Static")
  public_ip_sku      = lookup(each.value, "public_ip_sku", "Basic")
  public_ip_sku_tier = lookup(each.value, "public_ip_sku_tier", "Regional")
  tags               = var.tags

}

#Application Insight
module "Centralhub_Sit_ApplicationInsights" {

  depends_on = [
    module.Centralhub_Sit_rg,
    module.LogAnalyticsWorkspace
  ]
  source                  = "../../modules/ApplicationInsights"
  resourcegroupname       = var.centralhub_sit_rg
  location                = var.location
  applicationinsightsname = var.centralhub_sit_applicationinsightsname
  workspace_id            = module.LogAnalyticsWorkspace.azurerm_log_analytics_workspace_output
  tags                    = var.tags

}

#Service Bus Namespace
resource "azurerm_servicebus_namespace" "centralhub_sit_servicebus_namespace" {

  depends_on          = [module.Centralhub_Sit_rg]
  name                = var.centralhub_sit_servicebus_namespace_name
  location            = var.location
  resource_group_name = var.centralhub_sit_rg
  sku                 = "Premium"
  capacity            = 1
  tags                = var.tags

}

resource "azurerm_servicebus_namespace_authorization_rule" "centralhub_sit_servicebus_namespace_authorization_rule_01" {

  depends_on   = [azurerm_servicebus_namespace.centralhub_sit_servicebus_namespace]
  name         = "relay-policy"
  namespace_id = azurerm_servicebus_namespace.centralhub_sit_servicebus_namespace.id
  listen       = true
  send         = true
  manage       = true

}
resource "azurerm_servicebus_namespace_authorization_rule" "centralhub_sit_servicebus_namespace_authorization_rule_02" {

  depends_on   = [azurerm_servicebus_namespace.centralhub_sit_servicebus_namespace]
  name         = "RootManageSharedAccessKey"
  namespace_id = azurerm_servicebus_namespace.centralhub_sit_servicebus_namespace.id
  listen       = true
  send         = true
  manage       = true

}
resource "azurerm_servicebus_namespace_authorization_rule" "centralhub_sit_servicebus_namespace_authorization_rule_03" {

  depends_on   = [azurerm_servicebus_namespace.centralhub_sit_servicebus_namespace]
  name         = "ebssitsaskey"
  namespace_id = azurerm_servicebus_namespace.centralhub_sit_servicebus_namespace.id
  listen       = true
  send         = true
  manage       = true

}
resource "azurerm_servicebus_namespace_authorization_rule" "centralhub_sit_servicebus_namespace_authorization_rule_04" {

  depends_on   = [azurerm_servicebus_namespace.centralhub_sit_servicebus_namespace]
  name         = "PhoneixSITIntSASKey"
  namespace_id = azurerm_servicebus_namespace.centralhub_sit_servicebus_namespace.id
  listen       = true
  send         = true

}

resource "azurerm_servicebus_namespace_network_rule_set" "centralhub_sit_servicebus_namespace_network_rule_set" {

  depends_on                    = [azurerm_servicebus_namespace.centralhub_sit_servicebus_namespace]
  namespace_id                  = azurerm_servicebus_namespace.centralhub_sit_servicebus_namespace.id
  default_action                = "Deny"
  public_network_access_enabled = true
  ip_rules                      = ["155.49.0.0/16", "165.225.38.0/23", "165.225.8.0/23", "165.225.39.69", "165.225.209.38", "98.144.181.36", "192.181.104.8", "73.154.208.164", "24.1.4.228", "155.49.211.21", "172.19.94.224", "155.49.202.42", "165.225.221.43", "165.225.123.34", "172.29.4.164", "52.146.56.211", "172.29.4.128/25", "172.29.4.0/25", "52.146.56.211", "165.225.220.123", "155.49.28.114", "155.49.28.115", "155.49.211.82", "155.49.149.63", "155.49.203.134", "136.226.75.101", "136.226.75.115", "155.49.148.56"]

}

#API Management Service
resource "azurerm_api_management" "centralhub_sit_api_management_service" {

  depends_on                = [module.Centralhub_Sit_rg]
  name                      = var.centralhub_sit_api_management_service_name
  location                  = var.location
  resource_group_name       = var.centralhub_sit_rg
  publisher_name            = "HPHC"
  publisher_email           = "hemant_kohli@harvardpilgrim.org"
  notification_sender_email = "apimgmt-noreply@mail.windowsazure.com"
  sku_name                  = "Developer_1"

}

data "azurerm_subnet" "centralhub_sit_application_gateway_subnet" {

  depends_on           = [module.CHub_subnet]
  name                 = "eus-nonprod-sit-snet-agw-01"
  virtual_network_name = "eus-hub-central-vnet-01"
  resource_group_name  = var.centralhub_resourcegroupname

}

data "azurerm_public_ip" "centralhub_sit_application_gateway_publicIp" {

  depends_on          = [module.Centralhub_Sit_PublicIP]
  name                = "eus_hub_central_sit_agw_pip_01"
  resource_group_name = var.centralhub_sit_rg

}

#Application Gateway
resource "azurerm_application_gateway" "centralhub_sit_application_gateway" {

  depends_on = [
    module.Centralhub_Sit_rg,
    data.azurerm_subnet.centralhub_sit_application_gateway_subnet,
    data.azurerm_public_ip.centralhub_sit_application_gateway_publicIp
  ]
  name                = var.centralhub_sit_applicationgateway_name
  resource_group_name = var.centralhub_sit_rg
  location            = var.location
  tags                = var.tags

  sku {
    name     = "WAF_Medium"
    tier     = "WAF"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "gatewayIP01"
    subnet_id = data.azurerm_subnet.centralhub_sit_application_gateway_subnet.id
  }

  frontend_port {
    name = "port01"
    port = 443
  }

  frontend_ip_configuration {
    name                 = "frontend1"
    public_ip_address_id = data.azurerm_public_ip.centralhub_sit_application_gateway_publicIp.id
  }

  #NOTE: Need to provide Cert for "HTTPS" listeners. Need to provide all the details for cert.
  http_listener {
    name                           = "apigw-s-listener"
    frontend_ip_configuration_name = "frontend1"
    frontend_port_name             = "port01"
    protocol                       = "Https"
    host_name                      = "apigw-s.harvardpilgrim.org"
    ssl_certificate_name           = "cert-sit"
  }

  backend_address_pool {
    name         = "apimbackend"
    ip_addresses = ["172.30.253.101"]
  }

  backend_http_settings {
    name                  = "apimPoolSetting"
    cookie_based_affinity = "Disabled"
    port                  = 443
    protocol              = "Https"
    request_timeout       = 180
    host_name             = "apigw.harvardpilgrim.org"
    probe_name            = "apimproxyprobe"
  }

  request_routing_rule {
    name               = "apigw-s-rule"
    rule_type          = "PathBasedRouting"
    http_listener_name = "apigw-s-listener"
  }

  probe {
    name                = "apimproxyprobe"
    protocol            = "Https"
    host                = "apigw-s.harvardpilgrim.org"
    path                = "/status-0123456789abcdef"
    interval            = 30
    timeout             = 120
    unhealthy_threshold = 8
  }

}


