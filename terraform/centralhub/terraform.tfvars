#Reasource location
location                = "eastus"

#Resource tags
tags = {
    "Application Name"  = "CentralHub"
    "Dept Id"           = "411"
    "Environment"       = "CentralHub"
}

#Central Hub Resource Group
centralhub_resourcegroupname = "eus-hub-central-rg"

#CHub Virtual Network
vnets = {
    vnet1 = {
    vnet_name               = "eus-hub-central-vnet-01"
    vnet_address_space      = ["172.30.0.0/16"]
    }
}

#CHub Subnets
vnet_name    = "eus-hub-central-vnet-01"
subnets = {
    subnet1 = {
        subnet_name             = "eus-eventhubstorage-subnet"
        subnet_address_prefixes = ["172.30.3.0/28"]
    },
    subnet2 = {
        subnet_name             = "eus-prod-snet-apim-01"
        subnet_address_prefixes = ["172.30.254.112/28"]       
    }
    subnet3 = {
        subnet_name             = "eus-nonprod-sit-snet-apim-01"
        subnet_address_prefixes = ["172.30.253.96/28"]
    },
    subnet4 = {
        subnet_name             = "eus-hub-snet-vmss-p-01"
        subnet_address_prefixes = ["172.30.5.0/28"]
    },
    subnet5 = {
        subnet_name             = "eus-hub-snet-jumpbox-p-01"
        subnet_address_prefixes = ["172.30.254.48/28"]
    },
    subnet6 = {
        subnet_name             = "eus-nonprod-qa-subnet-asb-01"
        subnet_address_prefixes = ["172.30.255.96/28"]
    },
    subnet7 = {
        subnet_name             = "eus-test-snet-vmhop-01"
        subnet_address_prefixes = ["172.30.252.224/27"]
    },
    subnet8 = {
        subnet_name             = "eus-nonprod-snet-asb"
        subnet_address_prefixes = ["172.30.254.64/28"]
    },
    subnet9 = {
        subnet_name             = "subnetvm"
        subnet_address_prefixes = ["172.30.1.0/29"]
    },
    subnet10 = {
        subnet_name             = "eus-prod-snet-agw-01"
        subnet_address_prefixes = ["172.30.255.128/26"]
    },
    subnet11 = {
        subnet_name             = "eus-nonprod-snet-apim-01"
        subnet_address_prefixes = ["172.30.254.96/28"]
    },
    subnet12 = {
        subnet_name             = "GatewaySubnet"
        subnet_address_prefixes = ["172.30.255.224/27"]
    },
    subnet13 = {
        subnet_name             = "eus-nonprod-sit-snet-agw-01"
        subnet_address_prefixes = ["172.30.253.80/28"]
    },
    subnet14 = {
        subnet_name             = "eus-nonprod-snet-apim-internal-01"
        subnet_address_prefixes = ["172.30.255.192/27"]
    },
    subnet15 = {
        subnet_name             = "AzureFirewallSubnet"
        subnet_address_prefixes = ["172.30.255.0/26"]
    },
    subnet16 = {            
        subnet_name             = "eus-nonprod-qa-snet-apim"
        subnet_address_prefixes = ["172.30.4.0/28"]
    },
    subnet17 = {
        subnet_name             = "eus-hub-snet-compute-p-01"
        subnet_address_prefixes = ["172.30.240.0/26"]
    },
    subnet18 = {
        subnet_name             = "AzureBastionSubnet"
        subnet_address_prefixes = ["172.30.0.0/27"]
    },
    subnet19 = {
        subnet_name             = "testAGWsubnet"
        subnet_address_prefixes = ["172.30.2.0/28"]
    },
    subnet20 = {
        subnet_name             = "eus-nonprod-snet-agw-01"
        subnet_address_prefixes = ["172.30.254.80/28"]
    }
}

#Chub NSGs
nsgs = {
    nsg1 = {
    nsg_name = "basicNsgeus-hub-central-vnet-01-nic01"

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
    source_address_prefix                       = "172.30.240.5"
    source_address_prefixes                     = []
    source_application_security_group_ids       = []
    destination_address_prefix                  = "*"
    destination_address_prefixes                = []
    destination_application_security_group_ids  = []
    },
    {
    name                                        = "Port_DNS1"
    description                                 = null
    priority                                    = 111
    direction                                   = "Inbound"
    access                                      = "Allow"
    protocol                                    = "Udp"
    source_port_range                           = "*"
    source_port_ranges                          = []
    destination_port_range                      = "53"
    destination_port_ranges                     = []
    source_address_prefix                       = "*"
    source_address_prefixes                     = []
    source_application_security_group_ids       = []
    destination_address_prefix                  = "*"
    destination_address_prefixes                = []
    destination_application_security_group_ids  = []
    },
    {
    name                                        = "Port_80"
    description                                 = null
    priority                                    = 121
    direction                                   = "Inbound"
    access                                      = "Allow"
    protocol                                    = "*"
    source_port_range                           = "*"
    source_port_ranges                          = []
    destination_port_range                      = "80"
    destination_port_ranges                     = []
    source_address_prefix                       = "*"
    source_address_prefixes                     = []
    source_application_security_group_ids       = []
    destination_address_prefix                  = "*"
    destination_address_prefixes                = []
    destination_application_security_group_ids  = []
    },
    {
    name                                        = "Port_SSH"
    description                                 = null
    priority                                    = 131
    direction                                   = "Inbound"
    access                                      = "Allow"
    protocol                                    = "Tcp"
    source_port_range                           = "*"
    source_port_ranges                          = []
    destination_port_range                      = "22"
    destination_port_ranges                     = []
    source_address_prefix                       = "172.30.0.0/27"
    source_address_prefixes                     = []
    source_application_security_group_ids       = []
    destination_address_prefix                  = "*"
    destination_address_prefixes                = []
    destination_application_security_group_ids  = []
    }
    ]
    },

    nsg2 = {
    nsg_name = "eus-hub-snet-vmss-p-nsg"

    nsg_rules = [
    {
    name                                        = "Port_SSH"
    description                                 = null
    priority                                    = 100
    direction                                   = "Inbound"
    access                                      = "Allow"
    protocol                                    = "Tcp"
    source_port_range                           = "*"
    source_port_ranges                          = []
    destination_port_range                      = "22"
    destination_port_ranges                     = []
    source_address_prefix                       = "172.30.0.0/27"
    source_address_prefixes                     = []
    source_application_security_group_ids       = []
    destination_address_prefix                  = "*"
    destination_address_prefixes                = []
    destination_application_security_group_ids  = []
    },
    {
    name                                        = "Port_DNS"
    description                                 = null
    priority                                    = 110
    direction                                   = "Inbound"
    access                                      = "Allow"
    protocol                                    = "Tcp"
    source_port_range                           = "*"
    source_port_ranges                          = []
    destination_port_range                      = "53"
    destination_port_ranges                     = []
    source_address_prefix                       = "172.30.240.5"
    source_address_prefixes                     = []
    source_application_security_group_ids       = []
    destination_address_prefix                  = "*"
    destination_address_prefixes                = []
    destination_application_security_group_ids  = []
    },
    {
    name                                        = "Port_80"
    description                                 = null
    priority                                    = 120
    direction                                   = "Inbound"
    access                                      = "Allow"
    protocol                                    = "*"
    source_port_range                           = "*"
    source_port_ranges                          = []
    destination_port_range                      = "80"
    destination_port_ranges                     = []
    source_address_prefix                       = "*"
    source_address_prefixes                     = []
    source_application_security_group_ids       = []
    destination_address_prefix                  = "*"
    destination_address_prefixes                = []
    destination_application_security_group_ids  = []
    }
    ]
    },

    nsg3 = {
    nsg_name = "eus-hub-vm-01-nsg"

    nsg_rules = [
    {
    name                                        = "AllowSpoke"
    description                                 = null
    priority                                    = 100
    direction                                   = "Inbound"
    access                                      = "Allow"
    protocol                                    = "*"
    source_port_range                           = "*"
    source_port_ranges                          = []
    destination_port_range                      = "*"
    destination_port_ranges                     = []
    source_address_prefix                       = "172.29.4.32/28"
    source_address_prefixes                     = []
    source_application_security_group_ids       = []
    destination_address_prefix                  = "*"
    destination_address_prefixes                = []
    destination_application_security_group_ids  = []
    },
    {
    name                                        = "Allowspoke_1"
    description                                 = null
    priority                                    = 100
    direction                                   = "Outbound"
    access                                      = "Allow"
    protocol                                    = "*"
    source_port_range                           = "*"
    source_port_ranges                          = []
    destination_port_range                      = "*"
    destination_port_ranges                     = []
    source_address_prefix                       = "*"
    source_address_prefixes                     = []
    source_application_security_group_ids       = []
    destination_address_prefix                  = "172.29.4.32/28"
    destination_address_prefixes                = []
    destination_application_security_group_ids  = []
    }
    ]
    },

    nsg4 = {
    nsg_name = "teradata-debug-vm-nsg"

    nsg_rules = [
    {
    name                                        = "SSH"
    description                                 = null
    priority                                    = 300
    direction                                   = "Inbound"
    access                                      = "Allow"
    protocol                                    = "Tcp"
    source_port_range                           = "*"
    source_port_ranges                          = []
    destination_port_range                      = "22"
    destination_port_ranges                     = []
    source_address_prefix                       = "*"
    source_address_prefixes                     = []
    source_application_security_group_ids       = []
    destination_address_prefix                  = "*"
    destination_address_prefixes                = []
    destination_application_security_group_ids  = []
    },
    ]
    }
}

#Virtual Machine
vms = {
    vm1 = {
        virtualmachine_name         = "eus-central-hub-dnsbind-vm01"
        vm_size                     = "Standard_D2s_v3"
        vm_vnet_name                = "eus-hub-central-vnet-01"
        vm_subnet_name              = "eus-hub-snet-vmss-p-01"
        subnet_resource_group_name  = "eus-hub-central-rg"

        #NIC
        vm_nic_name                 = "eus-central-hub-dnsb777"
        ip_config_name              = "ipconfig1"
        private_ip_address_allocation = "Dynamic"                       #Default = "Dynamic"

        #storage_image_reference
        image_publisher             = "Canonical"
        image_offer                 = "UbuntuServer"
        image_sku                   = "18.04-LTS"
        image_version               = "latest"                          #Defualt = "latest"

        #OSDisk
        osdisk_name                 = "eus-central-hub-dnsbind-vm01_OsDisk_1"
        osdisk_caching              = "ReadWrite"
        osdisk_type                 = "Standard_LRS"
        os_disk_size_gb             = "30"
        
        #Data disks
        data_disks = []

        #deleteDisk #this line to delete the OS disk and data disk automatically when deleting the VM if it's true
        delete_os_disk_on_termination       = true                      #default it is "true"
        delete_data_disks_on_termination    = true                      #default it is "false"

        #osprofile
        computer_name               = "eus-hub-central-dns-vm-01"
        admin_usename               = "dnsadmin"
        admin_password              = "dnsadmin@123"

        disable_password_authentication     = false                     #Specifies whether password authentication should be disabled. If set to "false", an "admin_password" must be specified. by default it is true
    },

    vm2 = {
        virtualmachine_name         = "eus-hub-central-dns-vm-01"
        vm_size                     = "Standard_D2s_v3"
        vm_vnet_name                = "eus-hub-central-vnet-01"
        vm_subnet_name              = "eus-hub-snet-compute-p-01"
        subnet_resource_group_name  = "eus-hub-central-rg"

        #NIC
        vm_nic_name                 = "eus-hub-central-dns-569"
        ip_config_name              = "ipconfig1"
        private_ip_address_allocation = "Dynamic"                       


        #storage_image_reference
        image_publisher             = "Canonical"
        image_offer                 = "UbuntuServer"
        image_sku                   = "18.04-LTS"
        image_version               = "latest"                          

        #OSDisk
        osdisk_name                 = "eus-central-hub-dnsbind-vm01"
        osdisk_caching              = "ReadWrite"
        osdisk_type                 = "Premium_LRS"
        os_disk_size_gb             = "30"

        data_disks = []

        #deleteDisk #this line to delete the OS disk and data disk automatically when deleting the VM if it's true
        delete_os_disk_on_termination       = true                      #default it is "true"
        delete_data_disks_on_termination    = true                      #default it is "false"

        #osprofile
        computer_name               = "eus-hub-central-dns-vm-01"
        admin_usename               = "dnsadmin"
        admin_password              = "dnsadmin@123"

        disable_password_authentication     = false                 #Specifies whether password authentication should be disabled. If set to "false", an "admin_password" must be specified. by default it is true
    }
}

###############################################################################################################################################################################################################

###############################################################################################################################################################################################################

#Central Hub Resource Group
centralhub_virtualmachine_rg = "eus-hub-central-virtualmachine-rg"

virtualmachine_rg_nsgs = {
    nsg1 = {
    nsg_name = "Virtual-Machine-CHUB-nsg"

    nsg_rules = [
    {
    name                                        = "AllowAnyHTTPSInbound"
    description                                 = null
    priority                                    = 100
    direction                                   = "Inbound"
    access                                      = "Allow"
    protocol                                    = "Tcp"
    source_port_range                           = "*"
    source_port_ranges                          = []
    destination_port_range                      = "443"
    destination_port_ranges                     = []
    source_address_prefix                       = "*"
    source_address_prefixes                     = []
    source_application_security_group_ids       = []
    destination_address_prefix                  = "*"
    destination_address_prefixes                = []
    destination_application_security_group_ids  = []
    },
    {
    name                                        = "open-port-443"
    description                                 = null
    priority                                    = 900
    direction                                   = "Inbound"
    access                                      = "Allow"
    protocol                                    = "Udp"
    source_port_range                           = "*"
    source_port_ranges                          = []
    destination_port_range                      = "443"
    destination_port_ranges                     = []
    source_address_prefix                       = "*"
    source_address_prefixes                     = []
    source_application_security_group_ids       = []
    destination_address_prefix                  = "*"
    destination_address_prefixes                = []
    destination_application_security_group_ids  = []
    },
    ]
    }
}

virtualmachine_rg_vms = {
    vm1 = {
        virtualmachine_name         = "Virtual-Machine-CHUB"
        vm_size                     = "Standard_B2ms"
        vm_vnet_name                = "eus-hub-central-vnet-01"
        vm_subnet_name              = "subnetvm"
        subnet_resource_group_name  = "eus-hub-central-rg"

        #NIC
        vm_nic_name                 = "virtual-machine-c480"
        ip_config_name              = "ipconfig1"
        private_ip_address_allocation = "Dynamic"                       

        #storage_image_reference
        image_publisher             = "MicrosoftWindowsServer"          
        image_offer                 = "WindowsServer"
        image_sku                   = "2019-datacenter-gensecond"
        image_version               = "latest"                          

        #OSDisk
        osdisk_name                 = "Virtual-Machine-CHUB_disk1"
        osdisk_caching              = "ReadWrite"
        osdisk_type                 = "Standard_LRS"
        os_disk_size_gb             = "127"
        
        #Data disks
        data_disks = []

        #deleteDisk #this line to delete the OS disk and data disk automatically when deleting the VM if it's true
        delete_os_disk_on_termination       = true                      #default it is "true"
        delete_data_disks_on_termination    = true                      #default it is "false"

        #osprofile
        computer_name               = "Virtual-Machine"
        admin_usename               = "dnsadmin"
        admin_password              = "dnsadmin@123"
    }
}