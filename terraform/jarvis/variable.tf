variable "resourcegroupname" {
  type        = string
  description = "The name of the iwallet resource group"
}

variable "location" {
  type        = string
  description = "location for the  iwallet resources"
}

variable "storage_list" {
    type = list
    description = "The name of the Storage Account name"  
}

variable "containers_list" {
  type = list
}

variable "tags" {
  description = "Additional resource tags"
  type        = map(string)
}

variable "stack_version" {
  type = map
}

variable "function_app_application_settings"{
  type = map
}

variable "functionappname" {
 type = string 
}

variable "applicationinsightsname" {
  type        = string
  description = "location for the  iwallet resources"
}

variable "keyvaultname" {
  type        = string
  description = "location for the  iwallet resources"  
}

variable "serviceplanname" {
  type        = string
  description = "location for the  iwallet resources"
}

variable "ostype" {
  type        = string
  description = "location for the  iwallet resources"
}

variable "sku" {
  type        = string
  description = "location for the  iwallet resources"
}

variable "hphc_sku" {
  type        = string
  description = "location for the  iwallet resources"
}

variable "hphc_serviceplanname" {
  type        = string
  description = "location for the  iwallet resources"
}

variable "hphc_applicationinsightsname" {
  type        = string
  description = "location for the  iwallet resources"
}

variable "hphcappservicename" {
  type        = string
  description = "location for the  iwallet resources"
}

variable "hphc_stack_version" {
  type        = map
  description = "location for the  iwallet resources"
}

variable "app_settings"{
  type = map
}


#Networking and VM
# variable "vnets" {
#   type = map(object({
#     vnet_name = string
#     vnet_address_space = list(string)
#   }))
#   description = "For each vnet, create an object that contain fields"
# }

variable "subnets" {
  description = "For each subnet, create an object that contain fields"
  default     = {}
}

# variable "vnet_name" {
#   type = string
#   description = "Virtual network name for Subnet module"
# }

variable "nsgs" {
  type = map(object({
    nsg_name = string 
    nsg_rules = list(object({
    name                                        = string
    description                                 = string
    priority                                    = number
    direction                                   = string
    access                                      = string
    protocol                                    = string
    source_port_range                           = string
    source_port_ranges                          = list(string)
    destination_port_range                      = string
    destination_port_ranges                     = list(string)
    source_address_prefix                       = string
    source_address_prefixes                     = list(string)
    source_application_security_group_ids       = list(string)
    destination_address_prefix                  = string
    destination_address_prefixes                = list(string)
    destination_application_security_group_ids  = list(string)
  }))
  }))

  description = "Network Security Groups and NSG rules"
}

variable "vms" {
  description = "For each vms, create an object that contain fields"
  default     = {}
}