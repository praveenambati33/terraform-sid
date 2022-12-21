variable "location" {
  type        = string
  description = "resources should deploy only on 'eastus' as per the policy"
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "vnet_name" {
  type = string
  description = "Virtual network name"
}

variable "address_space" {
  type = list
  description = "Virtual network address space"
}

# variable "vnets" {
#   type = map(object({
#     name = string
#     address_space = list(string)
#     ddos_protection_plan = object({
#       enable = bool
#       id     = string
#   })
#     # default = {}
#   }))
#   description = "For each vnet, create an object that contain fields"
#   default     = {}
# }

# variable "vnets" {
#   description = "For each subnet, create an object that contain fields"
#   default     = {}
# }

#working ddos type
# variable "ddos_protection_plan" {
#   description = "The set of DDoS protection plan configuration"
#   type = object({
#     enable = bool
#     id     = string
#   })
#   default = {
#     enable = false
#       id = "ddos-id"
#   }
# }


