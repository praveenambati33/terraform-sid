#Example of .tfvars file for Multiple nsgs with all options

subnets = {

    subnet1 = {
        subnet_name = "subnet01-test"               #Subnet with all the available options with this module
        subnet_address_prefixes = ["10.30.0.0/28"]

        service_endpoints                               = ["list of serivce enpoints you want for this subnet", "serivce enpoint 02"]
        service_endpoint_policy_ids                     = "service_endpoint_policy_ids"
        private_endpoint_network_policies_enabled       = "private_endpoint_network_policies_enabled"
        private_link_service_network_policies_enabled   = "private_link_service_network_policies_enabled"

    },

    subnet2 = {
        subnet_name = "subnet02-test"
        subnet_address_prefixes = ["10.40.0.0/28"]       #Simple Subnet with name and address prefixes
    },

    subnet3 = {
        subnet_name = "eus-eventhubstorage-subnet"       #Delegated Subnet example
        subnet_address_prefixes = ["172.30.3.0/28"]

        delegation_settings = [
        {
            subnet_delegation_name         = "app-service-delegation"
            subnet_service_delegation_name = "Microsoft.Web/serverFarms"
        }
        ]
    }

}