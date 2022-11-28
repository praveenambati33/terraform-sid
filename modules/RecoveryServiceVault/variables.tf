variable "resourcegroupname" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "resources should deploy only on 'eastus' as per the policy"
}


variable "rsvname" {
  type = string
 description = "The name of the Recovery Service Vault name"
}

variable "rsvfspolicyname" {
  type = string
  description = "The name of the Recovery Service Vault policy name"
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
}