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

variable "nsg_name" {
  type = string
  description = "Virtual network name"
}

variable "nsg_rules" {
  type = list
  description = "Virtual network name"
}
