variable "location" {
  type        = string
  description = "resources should deploy only on 'eastus' as per the policy"
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
}

variable "resourcegroupname" {
  type        = string
  description = "The name of the resource group"
}

variable "subnets" {
  description = "For each subnet, create an object that contain fields"
  default     = {}
}

variable "subnet_name" {
  type = string
  description = "Virtual network name"
}

variable "virtual_network_name" {
  type = string
  description = "Virtual network name"
}

variable "subnet_address_prefixes" {
  type = list
  description = "Virtual network address space"
}

variable "service_endpoints" {
  type = list(string)
  description = "Virtual network name"
}

variable "service_endpoint_policy_ids" {
  type = list
  description = "Virtual network name"
}

variable "private_endpoint_network_policies_enabled" {
  type = string
  description = "Virtual network name"
}

variable "private_link_service_network_policies_enabled" {
  type = string
  description = "Virtual network name"
}

variable "delegation_settings" {
  type = list
  default = []
  
}


#Test variable for refernce - not working
# variable "delegation" {
#   type = object({
#     delegation_name                       = string

#     service_delegation = object({
#       service_delegation_name = string
#       service_delegation_actions = list(string)
#    })
#   })
#   description = ""
# } 
