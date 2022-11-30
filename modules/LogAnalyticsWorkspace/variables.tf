variable "resourcegroupname" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "resources should deploy only on 'eastus' as per the policy"
}

variable "lawworkspacename" {
  type = string  
}


variable "tags" {
  description = "Additional resource tags"
  type        = map(string)
}