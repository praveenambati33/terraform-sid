variable "resourcegroupname" {
  type        = string
  description = "The name of the iwallet resource group"
}

variable "location" {
  type        = string
  description = "location for the  iwallet resources"
}

variable "nodeserviceplanname" {
  type        = string
  description = "location for the  iwallet resources"
}

variable "node_ostype" {
  type        = string
  description = "location for the  iwallet resources"
}

variable "node_sku" {
  type        = string
  description = "location for the  iwallet resources"
}

variable "nodestorageaccountname" {
  type        = string
  description = "location for the  iwallet resources"
}

variable "nodefunctionappname" {
  type        = string
  description = "location for the  iwallet resources"

}

variable "node_stack_version" {
   type = map 
  description = "location for the  iwallet resources"
}

variable "applicationinsightsname" {
  type        = string
  description = "location for the  iwallet resources"
}

variable "nodersvname" {

  type        = string
  description = "location for the  iwallet resources"
}

variable "nodersvfspolicyname" {

  type        = string
  description = "location for the  iwallet resources"

}

variable "java_function_app_application_settings"{
  type = map
}

variable "node_function_app_application_settings"{
  type = map
}


# Java Function App

variable "javaserviceplanname" {
  type        = string
  description = "location for the  iwallet resources"
}

variable "java_ostype" {
  type        = string
  description = "location for the  iwallet resources"
}

variable "java_sku" {
  type        = string
  description = "location for the  iwallet resources"
}

variable "javastorageaccountname" {
  type        = string
  description = "location for the  iwallet resources"
}

variable "javafunctionappname" {
  type        = string
  description = "location for the  iwallet resources"

}

variable "java_stack_version" {
   type = map
  description = "location for the  iwallet resources"
}

variable "javarsvname" {
  type        = string
  description = "location for the  iwallet resources"
}

variable "javarsvfspolicyname" {
  type        = string
  description = "location for the  iwallet resources"
}


# CosomosDB

variable "iwalletcosmosdbaccount" {
  type = string
}

variable "iwalletcosmosdb" {
  type = string
}

variable "iwalletcosmosdbcontainer1" {
  type = string
}

variable "leasepartitionkey" {
  type = string
}

variable "iwalletcosmosdbcontainer2" {
  type = string
}

variable "walletpartitionkey" {
  type = string
}

# key vault 

variable "appkeyvaultname" {
  type = string
}

variable "cosmoskeyvaultname" {
  type = string
}


#DataFactory
variable "iwalletdfname" {
  type = string
}

variable "iwalletasg" {
  type = string
}

#Storage Account
variable "storageaccountname" {
  type = string
}

variable "nodecontainerlist" {
  type = list
}

#Event Hub 

variable "eventhubstorageaccountname" {
  type = string
}

variable "eventhubcontainers_list" {
  type = list(any)
}

variable "iwalletensname" {
  type = string
}


variable "eventhubs" {
  type = map(object({
    eventhubname        = string
    blob_container_name = string
  }))
}


variable "tags" {
  description = "Additional resource tags"
  type        = map(string)
}

