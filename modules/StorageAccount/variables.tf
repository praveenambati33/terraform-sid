variable "resourcegroupname" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "resources should deploy only on 'eastus' as per the policy"
}

variable "containers_list" {
  type = list
 }

 variable "storage_list" {
  type = list
 }

 variable "tags" {
  description = "Resource tags"
  type        = map(string)
}

