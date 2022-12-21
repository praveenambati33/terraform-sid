#Example of NSG tfvars for Different NSGs and NSG rules

nsgs = {
    nsg1 = {
    nsg_name = "nsg1"

    nsg_rules = [
    {
    name                                        = "Port_DNS"
    description                                 = null
    priority                                    = 100
    direction                                   = "Inbound"
    access                                      = "Allow"
    protocol                                    = "Tcp"
    source_port_range                           = "*"
    source_port_ranges                          = []
    destination_port_range                      = "53"
    destination_port_ranges                     = []
    source_address_prefix                       = null
    source_address_prefixes                     = ["172.30.240.5","172.50.240.5","172.60.240.5"]
    source_application_security_group_ids       = []
    destination_address_prefix                  = "Any"
    destination_address_prefixes                = []
    destination_application_security_group_ids  = []
    },
    {
    name                                        = "Port_DNS2"
    description                                 = null
    priority                                    = 100
    direction                                   = "Inbound"
    access                                      = "Allow"
    protocol                                    = "Tcp"
    source_port_range                           = "*"
    source_port_ranges                          = []
    destination_port_range                      = "53"
    destination_port_ranges                     = []
    source_address_prefix                       = "172.40.240.5"
    source_address_prefixes                     = []
    source_application_security_group_ids       = []
    destination_address_prefix                  = "Any"
    destination_address_prefixes                = []
    destination_application_security_group_ids  = []
    }
    ]
    },

    nsg2 = {
    nsg_name = "nsg2"
    nsg_rules = []
    },

    nsg3 = {
    nsg_name = "nsg3"

    nsg_rules = [
    {
    name                                        = "Port_DNS2"
    description                                 = null
    priority                                    = 100
    direction                                   = "Outbound"
    access                                      = "Allow"
    protocol                                    = "Tcp"
    source_port_range                           = "*"
    source_port_ranges                          = []
    destination_port_range                      = "53"
    destination_port_ranges                     = []
    source_address_prefix                       = "172.40.240.5"
    source_address_prefixes                     = []
    source_application_security_group_ids       = []
    destination_address_prefix                  = "Any"
    destination_address_prefixes                = []
    destination_application_security_group_ids  = []
    }
    ]
    }
}