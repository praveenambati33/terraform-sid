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

variable "tags" {
  description = "Resource tags"
  type        = map(string)
}

