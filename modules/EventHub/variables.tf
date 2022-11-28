variable "resourcegroupname" {
  type        = string
  description = "The name of the iwallet resource group"
}

variable "location" {
  type        = string
  description = "location for the  iwallet resources"
}

variable "iwalletensname" {
  type = string  
}

variable "eventhubs" {
  type = map(object({
    eventhubname                  = string
    blob_container_name    = string
  }))
}

variable "eventhubstorageaccountname" {
    type = string
}

 variable "eventhubcontainers_list" {
  type = list(any)  
  
 }
