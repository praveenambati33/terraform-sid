#Common Variables

variable "location" {
  type        = string
  description = "Resource loaction"
  default     = "eastus"
}

variable "tags" {
  description = "Additional resource tags"
  type        = map(string)
}

###########################################################################################################################################################

###########################################################################################################################################################

#Central Hub Central RG Variables

variable "centralhub_resourcegroupname" {
  type        = string
  description = "Resource group name"
}

variable "vnets" {
  type = map(object({
    vnet_name          = string
    vnet_address_space = list(string)
  }))
  description = "For each vnet, create an object that contain fields"
}

variable "subnets" {
  description = "For each subnet, create an object that contain fields"
  default     = {}
}

variable "vnet_name" {
  type        = string
  description = "Virtual network name for Subnet module"
}

variable "nsgs" {
  type = map(object({
    nsg_name = string
    nsg_rules = list(object({
      name                                       = string
      description                                = string
      priority                                   = number
      direction                                  = string
      access                                     = string
      protocol                                   = string
      source_port_range                          = string
      source_port_ranges                         = list(string)
      destination_port_range                     = string
      destination_port_ranges                    = list(string)
      source_address_prefix                      = string
      source_address_prefixes                    = list(string)
      source_application_security_group_ids      = list(string)
      destination_address_prefix                 = string
      destination_address_prefixes               = list(string)
      destination_application_security_group_ids = list(string)
    }))
  }))

  description = "Network Security Groups and NSG rules"
}

variable "vms" {
  description = "For each vms, create an object that contain fields"
  default     = {}
}

variable "vmss" {
  description = "For each vmss, create an object that contain fields"
  default     = {}
}

variable "publicIps" {
  description = "For each public IPs, create an object that contain fields"
  default     = {}
}

variable "centralhub_keyvaultname" {
  type        = string
  description = "The name of the key vault"
}

variable "storageaccount_01" {
  description = "Storage account list 1"
}

variable "containers_list01" {
  description = "Storage account container list 1"
}

variable "storageaccount_02" {
  description = "Storage account list 2"
}

variable "containers_list02" {
  description = "Storage account container list 2"
}

variable "lawworkspacename" {
  type        = string
  description = "Log analytics workspace name"
}

variable "law_solution_name" {
  description = "Log analytics workspace Solution name"
}

variable "private_dns_zone_name" {
  description = "Private DNS zone name"
}

variable "private_dns_a_record_01" {
  description = "Private DNS zone A record 1"
}

variable "private_dns_a_record_02" {
  description = "Private DNS zone A record 2"
}

variable "rsv_name" {
  description = "Recovery Service Vault name"
}

variable "rsv_sku" {
  description = "Recovery Service Vault SKU"
}

variable "route_table_name" {
  description = "Route Table name"
}

variable "firewall_name" {
  description = "Firewall name"
}

variable "virtual_network_gateway_name" {
  description = "Virtual network gateway name"
}

variable "local_network_gateway_name" {
  description = "Local network gateway name"
}

variable "virtual_network_gateway_connection_name" {
  description = "Virtual network gateway Connection name"
}

variable "bastion_name" {
  description = "Bastion name"
}

#Event Hub 
variable "eventhubstorageaccountname" {
  type = string
}

variable "eventhubcontainers_list" {
  type = list(any)
}

variable "eventhub_namespace_name" {
  type = string
}

variable "eventhubs" {
  type = map(object({
    eventhubname        = string
    blob_container_name = string
  }))
}

#Load Balancer name
variable "lb_name" {
  description = "Load Balancer name"
}

#########################################################################################################################################################

#########################################################################################################################################################

#Central Hub Virtual-Machine RG Variables

variable "centralhub_virtualmachine_rg" {
  type        = string
  description = "Resource group name"
}

variable "virtualmachine_rg_nsgs" {
  type = map(object({
    nsg_name = string
    nsg_rules = list(object({
      name                                       = string
      description                                = string
      priority                                   = number
      direction                                  = string
      access                                     = string
      protocol                                   = string
      source_port_range                          = string
      source_port_ranges                         = list(string)
      destination_port_range                     = string
      destination_port_ranges                    = list(string)
      source_address_prefix                      = string
      source_address_prefixes                    = list(string)
      source_application_security_group_ids      = list(string)
      destination_address_prefix                 = string
      destination_address_prefixes               = list(string)
      destination_application_security_group_ids = list(string)
    }))
  }))

  description = "Network Security Groups and NSG rules"
}

variable "virtualmachine_rg_vms" {
  description = "For each vms, create an object that contain fields"
  default     = {}
}

######################################################################################################################################################

######################################################################################################################################################

#Central Hub PROD RG Variables

variable "centralhub_prod_rg" {
  type        = string
  description = "Resource group name"
}

variable "centralhub_prod_nsgs" {
  type = map(object({
    nsg_name = string
    nsg_rules = list(object({
      name                                       = string
      description                                = string
      priority                                   = number
      direction                                  = string
      access                                     = string
      protocol                                   = string
      source_port_range                          = string
      source_port_ranges                         = list(string)
      destination_port_range                     = string
      destination_port_ranges                    = list(string)
      source_address_prefix                      = string
      source_address_prefixes                    = list(string)
      source_application_security_group_ids      = list(string)
      destination_address_prefix                 = string
      destination_address_prefixes               = list(string)
      destination_application_security_group_ids = list(string)
    }))
  }))

  description = "Network Security Groups and NSG rules"
}

variable "centralhub_prod_publicIps" {
  description = "For each public IPs, create an object that contain fields"
  default     = {}
}

variable "centralhub_prod_storageaccount" {
  description = "Storage account list 1"
}

variable "centralhub_prod_containers_list" {
  description = "Storage account container list 1"
}

variable "centralhub_prod_applicationinsightsname" {
  description = "Central Hub Prod Application Insight name"
}

variable "centralhub_prod_applicationgateway_name" {
  description = "Central Hub Prod Application Gateway name"
}

variable "centralhub_prod_servicebus_namespace_name" {
  description = "Central Hub Prod Service Bus Namespace name"
}

variable "centralhub_prod_api_management_service_name" {
  description = "Central Hub Prod API Management Service name"
}


####################################################################################################################################################

####################################################################################################################################################

#Central Hub SIT RG Variables

variable "centralhub_sit_rg" {
  type        = string
  description = "Resource group name"
}

variable "centralhub_sit_nsgs" {
  type = map(object({
    nsg_name = string
    nsg_rules = list(object({
      name                                       = string
      description                                = string
      priority                                   = number
      direction                                  = string
      access                                     = string
      protocol                                   = string
      source_port_range                          = string
      source_port_ranges                         = list(string)
      destination_port_range                     = string
      destination_port_ranges                    = list(string)
      source_address_prefix                      = string
      source_address_prefixes                    = list(string)
      source_application_security_group_ids      = list(string)
      destination_address_prefix                 = string
      destination_address_prefixes               = list(string)
      destination_application_security_group_ids = list(string)
    }))
  }))

  description = "Network Security Groups and NSG rules"
}

variable "centralhub_sit_publicIps" {
  description = "For each public IPs, create an object that contain fields"
  default     = {}
}

variable "centralhub_sit_storageaccount" {
  description = "Storage account list 1"
}

variable "centralhub_sit_containers_list" {
  description = "Storage account container list 1"
}

variable "centralhub_sit_applicationinsightsname" {
  description = "Central Hub Prod Application Insight name"
}

variable "centralhub_sit_applicationgateway_name" {
  description = "Central Hub Prod Application Gateway name"
}

variable "centralhub_sit_servicebus_namespace_name" {
  description = "Central Hub Prod Service Bus Namespace name"
}

variable "centralhub_sit_api_management_service_name" {
  description = "Central Hub Prod API Management Service name"
}
