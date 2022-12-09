variable "asp-resourcegroupname" {
  type        = string
  description = "The name of the iwallet resource group"
}

variable "location" {
  type        = string
  description = "location for the  iwallet resources"
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
