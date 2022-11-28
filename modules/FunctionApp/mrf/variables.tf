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

  description = "location for the  iwallet resources"
}

variable "ostype" {
  type = string

  description = "location for the  iwallet resources"
}

variable "sku" {
  type = string

  description = "location for the  iwallet resources"
}

variable "stroageaccountname" {
  type = string

  description = "location for the  iwallet resources"
}

variable "accounttier" {
  type = string

  description = "location for the  iwallet resources"
}

variable "replicationtype" {
  type = string

  description = "location for the  iwallet resources"

}

variable "functionappname" {
  type = string

  description = "location for the  iwallet resources"

}

# variable "appsettings" {
#   type = map(any)

#   description = "location for the  iwallet resources"
# }

variable "stackversion" {
  type = string

  description = "location for the  iwallet resources"
}

variable "applicationinsightsname" {
  type        = string
  description = "location for the  iwallet resources"
}


variable "lawworkspace" {
  type = string  
}

variable "tags" {
  description = "Additional resource tags"
  type        = map(string)
}