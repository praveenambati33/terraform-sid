variable "resourcegroupname" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "resources should deploy only on 'eastus' as per the policy"
}


variable "iwalletcosmosdbaccount" {
  type = string
   description = "The name of the Cosmos Database Account"
}

variable "iwalletcosmosdb" {
  type = string
    description = "The name of the Cosmos DB"
}

variable "iwalletcosmosdbcontainer1" {
  type = string
  description = "The name of the DB Conatiner for lease"
}

variable "leasepartitionkey" {
  type = string
  description = "The name of the Lease partition key"
}

variable "iwalletcosmosdbcontainer2" {
  type = string
  description = "The name of the Wallet container"
}

variable "walletpartitionkey" {
  type = string
  description = "The name of the wallet partition key"
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
}