
variable "location" {
    type = string
    description = "Resource loaction"
    default = "eastus"
}

variable "tags" {
  description = "Additional resource tags"
  type        = map(string)
}

variable "centralhub_resourcegroupname" {
    type = string
    description = "Resource group name"
}

variable "vnets" {
  type = map(object({
    vnet_name = string
    vnet_address_space = list(string)
  }))
  description = "For each vnet, create an object that contain fields"
}

variable "subnets" {
  description = "For each subnet, create an object that contain fields"
  default     = {}
}

variable "vnet_name" {
  type = string
  description = "Virtual network name for Subnet module"
}

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


#########################################################################################################

#########################################################################################################

variable "centralhub_virtualmachine_rg" {
    type = string
    description = "Resource group name"
}

variable "virtualmachine_rg_nsgs" {
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

variable "virtualmachine_rg_vms" {
  description = "For each vms, create an object that contain fields"
  default     = {}
}

########################################################################################################



