variable "resourcegroupname" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "resources should deploy only on 'eastus' as per the policy"
}

variable "storageaccountname" {
    type = string
    description = "The name of the Storage Account name"  
}

 variable "containers_list" {
  type = list   
  description = "Containers names for Storage Account"
 }

 variable "tags" {
  description = "Resource tags"
  type        = map(string)
}

