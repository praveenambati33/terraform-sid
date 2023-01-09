variable "resourcegroupname" {
  type        = string
  description = "The name of the iwallet resource group"
}

variable "location" {
  type        = string
  description = "location for the  iwallet resources"
}

variable "vnet_name" {
  type = string
}

variable "address_space" {
  type =  list(string) 
}

variable "subnet_name" {
  type = string  
}

variable "address_prefixes" {
  type =  list(string)
  
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

variable "tags" {
  description = "Additional resource tags"
  type        = map(string)
}