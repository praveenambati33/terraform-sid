variable "resourcegroupname" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "resources should deploy only on 'eastus' as per the policy"
}

variable "functionappname" {
  type = string

  description = "location for the  iwallet resources"

}

variable "tags" {
  description = "Additional resource tags"
  type        = map(string)
}


variable "storageaccountname"{
  type = string 
  description = "The name of the WebApp SKU"
}

variable "stack_version" {
  type = map
}


variable "service_plan_id" {
  type        = string
  description = "Service Plan ID."
}

variable "storage_account_access_key" {
  type        = string
  description = "Storage account access key."
}       

variable "function_app_application_settings"{
  type = map
}

variable "application_insights_key" {
  type = string  
}