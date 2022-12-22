variable "resourcegroupname" {
  type        = string
  description = "The name of the iwallet resource group"
}

variable "location" {
  type        = string
  description = "location for the  iwallet resources"
}

variable "storageaccountname" {
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