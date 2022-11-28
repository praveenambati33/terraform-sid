variable "resourcegroupname" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "resources should deploy only on 'eastus' as per the policy"
}

variable "iwalletensname" {
  type = string  
  description = "The name of the Event Hub Namespace"
}

variable "eventhubs" {
  type = map(object({
    eventhubname                  = string
    blob_container_name    = string
  }))
  description = "List of EventHubs"
}

variable "eventhubstorageaccountname" {
    type = string
    description = "EventHub capture storage account"
}

 variable "eventhubcontainers_list" {
  type = list(any)  
  description = "EventHub containers for capturing the events for event hub"
  
 }


variable "tags" {
  description = "Resource tags"
  type        = map(string)
}