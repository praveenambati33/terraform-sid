variable "resourcegroupname" {
  type        = string
  description = "The name of the iwallet resource group"
}

variable "location" {
  type        = string
  description = "location for the  iwallet resources"
}

variable "serviceplanname" {
  type        = string
  description = "location for the  iwallet resources"
}

variable "ostype" {
  type        = string
  description = "location for the  iwallet resources"
}

variable "sku" {
  type        = string
  description = "location for the  iwallet resources"
}

variable "stroageaccountname" {
  type        = string
  description = "location for the  iwallet resources"
}

variable "accounttier" {
  type        = string
  description = "location for the  iwallet resources"
}

variable "replicationtype" {
  type        = string
  description = "location for the  iwallet resources"

}

variable "functionappname" {
  type        = string
  description = "location for the  iwallet resources"

}

variable "stackversion" {
  type        = string
  description = "location for the  iwallet resources"
}

variable "applicationinsightsname" {
  type        = string
  description = "location for the  iwallet resources"
}

variable "rsvname" {

  type        = string
  description = "location for the  iwallet resources"
}

variable "rsvfspolicyname" {

  type        = string
  description = "location for the  iwallet resources"

}

# Java Function App

variable "javaserviceplanname" {
  type        = string
  description = "location for the  iwallet resources"
}

variable "javaostype" {
  type        = string
  description = "location for the  iwallet resources"
}

variable "javasku" {
  type        = string
  description = "location for the  iwallet resources"
}

variable "javastroageaccountname" {
  type        = string
  description = "location for the  iwallet resources"
}

variable "javaaccounttier" {
  type        = string
  description = "location for the  iwallet resources"
}

variable "javareplicationtype" {
  type        = string
  description = "location for the  iwallet resources"

}

variable "javafunctionappname" {
  type        = string
  description = "location for the  iwallet resources"

}

variable "javastackversion" {
  type        = string
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

variable "keyvaultname" {
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

variable "containers_list" {
  type = list(any)
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
