#Terraform.tfvars example for multiple vnet for this virtual network module

vnets = {
    vnet1 = {
    vnet_name    = "vnet01-name"
    vnet_address_space   = ["10.10.0.0/16"]
    },
    vnet2 = {
    vnet_name    = "vnet02-name"
    vnet_address_space   = ["10.11.0/16"]
    }
}