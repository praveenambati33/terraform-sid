variable "resourcegroupname" {
  type        = string
  description = "The name of the iwallet resource group"
}

variable "location" {
  type        = string
  description = "location for the  iwallet resources"
}


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