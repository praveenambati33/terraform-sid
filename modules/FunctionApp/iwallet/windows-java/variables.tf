variable "resourcegroupname" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "resources should deploy only on 'eastus' as per the policy"
}

variable "javaserviceplanname" {
  type    = string
  description = "The name of the Servie Plan"
}

variable "javaostype" {
  type    = string
  description = "The name of the WebApp OS type"
}

variable "javasku" {
  type    = string
  description = "The name of the WebApp SKU"
}

variable "javastroageaccountname" {
  type    = string
  description = "The name of the storage account"
}

variable "javaaccounttier" {
  type    = string
  description = "The name of the storage account tier"
}

variable "javareplicationtype" {
  type    = string
  description = "The name of the replication type"

}

variable "javafunctionappname" {
  type    = string
  description = "The name of the java function app"

}

variable "javastackversion" {
    type = string
    description = "The name of the java version for webapp"
}



variable "fn_ai_key_out" {
  type = string
  description = "Application Insights id output for java app to tie up with"
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
}