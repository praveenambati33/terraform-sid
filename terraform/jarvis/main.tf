locals {
  Application = "jarvis"

}

#Create Resource Group
module "ResourceGroup" {
  source                        = "../../modules/ResourceGroup"
  resource_group_name           = var.resource_group_name
  location                      = var.location
}