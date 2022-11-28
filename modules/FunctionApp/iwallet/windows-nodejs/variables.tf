variable "resourcegroupname" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "resources should deploy only on 'eastus' as per the policy"
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

variable "stroageaccountname" {
  type = string
  description = "The name of the storage account"
}

variable "accounttier" {
  type = string
  description = "The name of the storage account tier"
}

variable "replicationtype" {
  type = string
  description = "The name of the replication type"
}

variable "functionappname" {
  type = string
  description = "The name of the node function app"
}

# variable "appsettings" {
#   type = map(any)

#   description = "location for the  iwallet resources"
# }

variable "stackversion" {
  type = string
  description = "The name of the node version for webapp"
}

variable "applicationinsightsname" {
  type        = string
  description = "Then name of the applicaiton insights for node js app"
}


variable "tags" {
  description = "Resource tags"
  type        = map(string)
}