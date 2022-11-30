variable "resourcegroupname" {
  type        = string
  description = "The name of the iwallet resource group"
}

variable "asp-resourcegroupname" {
  type        = string
  description = "The name of the iwallet resource group"
}

variable "location" {
  type        = string
  description = "location for the  iwallet resources"
}

variable "storageaccountname" {
    type = string
    description = "The name of the Storage Account name"  
}

variable "storageaccountlogsname" {
    type = string
    description = "The name of the Storage Account name"  
}

variable "serviceplanname" {
  type = string
  description = "The name of the Servie Plan"
}

variable "ostype" {
  type = string
  description = "The name of the WebApp OS type"
}

variable "sku" {
  type = string
  description = "The name of the WebApp SKU"
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

variable "lawworkspacename" {
  type = string  
}

variable "applicationinsightsname" {
  type        = string
  description = "location for the  iwallet resources"
}