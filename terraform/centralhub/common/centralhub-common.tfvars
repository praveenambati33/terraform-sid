#Reasource location
location = "eastus"

#Resource tags
tags = {
  "Application Name" = "CentralHub"
  "Dept Id"          = "411"
  "Environment"      = "CentralHub"
}

#######################################################################################################################################################

#Central Hub Central Resource Group
centralhub_resourcegroupname = "eus-hub-central-UAT-rg" #"eus-hub-central-rg"

#Keyvault
centralhub_keyvaultname = "eus-hub-kv"

# Log Analytics workspace for AI 
lawworkspacename  = "eus-hub-log-analws-02"
law_solution_name = "NetworkMonitoring"
# applicationinsightsname = "eus-s-mrf-fnapp-02" #NA

#RSV
rsv_name = "eus-hub-central-dns-vm-01-recoveryvault"
rsv_sku  = "RS0"

#Private DNS Zone
private_dns_zone_name   = "privatelink.servicebus.windows.net"
private_dns_a_record_01 = "eus-hub-central-nonprod-qa-sb-01"
private_dns_a_record_02 = "eus-hub-central-nonprod-sb-01"

#Route Table
route_table_name = "eus-vpngateway-2-firewall-rt"

#Firewall
firewall_name = "eus-hub-central-fw01"

#Virtual Network Gateway
virtual_network_gateway_name            = "eus-hub-central-vng-01"
local_network_gateway_name              = "eus-hub-central-s2s-lng-01"
virtual_network_gateway_connection_name = "eus-hub-central-s2s-connection-01"

#Bastion
bastion_name = "eus-hub-central-vnet-01-bastion"

#Event Hub Namespace and Event Hubs
eventhub_namespace_name = "eus-hub-central-eventhub01"

eventhubs = {
  "hub1" = {
    eventhubname        = "eus-chub-firewall-eventhub"
    blob_container_name = "eventhubcontainer"
  }
}

eventhubstorageaccountname = "euseventhubstorage01"
eventhubcontainers_list = [
  { name = "eventhubcontainer", access_type = "private" }
]

# Storage Accounts
storageaccount_01 = ["euscloudshellstg"]
containers_list01 = [
  { name = "poc-nva-templates", access_type = "container" },
  { name = "cert", access_type = "private" }
]

storageaccount_02 = ["euscloudshellstg"]
containers_list02 = []

#CHub Virtual Network
vnets = {
  vnet1 = {
    vnet_name          = "eus-hub-central-vnet-01"
    vnet_address_space = ["172.30.0.0/16"]
  }
}

#CHub Subnets
vnet_name = "eus-hub-central-vnet-01"
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
    nsg_name = "basicNsgeus-hub-central-UAT-vnet-01-nic01" #"basicNsgeus-hub-central-vnet-01-nic01"

    nsg_rules = [
      {
        name                                       = "Port_DNS"
        description                                = null
        priority                                   = 100
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "Tcp"
        source_port_range                          = "*"
        source_port_ranges                         = []
        destination_port_range                     = "53"
        destination_port_ranges                    = []
        source_address_prefix                      = "172.30.240.5"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
      },
      {
        name                                       = "Port_DNS1"
        description                                = null
        priority                                   = 111
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "Udp"
        source_port_range                          = "*"
        source_port_ranges                         = []
        destination_port_range                     = "53"
        destination_port_ranges                    = []
        source_address_prefix                      = "*"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
      },
      {
        name                                       = "Port_80"
        description                                = null
        priority                                   = 121
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        source_port_ranges                         = []
        destination_port_range                     = "80"
        destination_port_ranges                    = []
        source_address_prefix                      = "*"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
      },
      {
        name                                       = "Port_SSH"
        description                                = null
        priority                                   = 131
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "Tcp"
        source_port_range                          = "*"
        source_port_ranges                         = []
        destination_port_range                     = "22"
        destination_port_ranges                    = []
        source_address_prefix                      = "172.30.0.0/27"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
      }
    ]
  },

  # nsg2 = {
  #   nsg_name = "eus-hub-snet-vmss-p-nsg"

  #   nsg_rules = [
  #     {
  #       name                                       = "Port_SSH"
  #       description                                = null
  #       priority                                   = 100
  #       direction                                  = "Inbound"
  #       access                                     = "Allow"
  #       protocol                                   = "Tcp"
  #       source_port_range                          = "*"
  #       source_port_ranges                         = []
  #       destination_port_range                     = "22"
  #       destination_port_ranges                    = []
  #       source_address_prefix                      = "172.30.0.0/27"
  #       source_address_prefixes                    = []
  #       source_application_security_group_ids      = []
  #       destination_address_prefix                 = "*"
  #       destination_address_prefixes               = []
  #       destination_application_security_group_ids = []
  #     },
  #     {
  #       name                                       = "Port_DNS"
  #       description                                = null
  #       priority                                   = 110
  #       direction                                  = "Inbound"
  #       access                                     = "Allow"
  #       protocol                                   = "Tcp"
  #       source_port_range                          = "*"
  #       source_port_ranges                         = []
  #       destination_port_range                     = "53"
  #       destination_port_ranges                    = []
  #       source_address_prefix                      = "172.30.240.5"
  #       source_address_prefixes                    = []
  #       source_application_security_group_ids      = []
  #       destination_address_prefix                 = "*"
  #       destination_address_prefixes               = []
  #       destination_application_security_group_ids = []
  #     },
  #     {
  #       name                                       = "Port_80"
  #       description                                = null
  #       priority                                   = 120
  #       direction                                  = "Inbound"
  #       access                                     = "Allow"
  #       protocol                                   = "*"
  #       source_port_range                          = "*"
  #       source_port_ranges                         = []
  #       destination_port_range                     = "80"
  #       destination_port_ranges                    = []
  #       source_address_prefix                      = "*"
  #       source_address_prefixes                    = []
  #       source_application_security_group_ids      = []
  #       destination_address_prefix                 = "*"
  #       destination_address_prefixes               = []
  #       destination_application_security_group_ids = []
  #     }
  #   ]
  # },

  # nsg3 = {
  #   nsg_name = "eus-hub-vm-01-nsg"

  #   nsg_rules = [
  #     {
  #       name                                       = "AllowSpoke"
  #       description                                = null
  #       priority                                   = 100
  #       direction                                  = "Inbound"
  #       access                                     = "Allow"
  #       protocol                                   = "*"
  #       source_port_range                          = "*"
  #       source_port_ranges                         = []
  #       destination_port_range                     = "*"
  #       destination_port_ranges                    = []
  #       source_address_prefix                      = "172.29.4.32/28"
  #       source_address_prefixes                    = []
  #       source_application_security_group_ids      = []
  #       destination_address_prefix                 = "*"
  #       destination_address_prefixes               = []
  #       destination_application_security_group_ids = []
  #     },
  #     {
  #       name                                       = "Allowspoke_1"
  #       description                                = null
  #       priority                                   = 100
  #       direction                                  = "Outbound"
  #       access                                     = "Allow"
  #       protocol                                   = "*"
  #       source_port_range                          = "*"
  #       source_port_ranges                         = []
  #       destination_port_range                     = "*"
  #       destination_port_ranges                    = []
  #       source_address_prefix                      = "*"
  #       source_address_prefixes                    = []
  #       source_application_security_group_ids      = []
  #       destination_address_prefix                 = "172.29.4.32/28"
  #       destination_address_prefixes               = []
  #       destination_application_security_group_ids = []
  #     }
  #   ]
  # },

  # nsg4 = {
  #   nsg_name = "teradata-debug-vm-nsg"

  #   nsg_rules = [
  #     {
  #       name                                       = "SSH"
  #       description                                = null
  #       priority                                   = 300
  #       direction                                  = "Inbound"
  #       access                                     = "Allow"
  #       protocol                                   = "Tcp"
  #       source_port_range                          = "*"
  #       source_port_ranges                         = []
  #       destination_port_range                     = "22"
  #       destination_port_ranges                    = []
  #       source_address_prefix                      = "*"
  #       source_address_prefixes                    = []
  #       source_application_security_group_ids      = []
  #       destination_address_prefix                 = "*"
  #       destination_address_prefixes               = []
  #       destination_application_security_group_ids = []
  #     },
  #   ]
  # }
}

#Virtual Machine
vms = {
  vm1 = {
    virtualmachine_name        = "eus-central-hub-dnsbind-vm01"
    vm_size                    = "Standard_D2s_v3"
    vm_vnet_name               = "eus-hub-central-vnet-01"
    vm_subnet_name             = "eus-hub-snet-vmss-p-01"
    subnet_resource_group_name = "eus-hub-central-rg"

    #NIC
    vm_nic_name                   = "eus-central-hub-dnsb777"
    ip_config_name                = "ipconfig1"
    private_ip_address_allocation = "Dynamic" #Default = "Dynamic"

    #storage_image_reference
    image_publisher = "Canonical"
    image_offer     = "UbuntuServer"
    image_sku       = "18.04-LTS"
    image_version   = "latest" #Defualt = "latest"

    #OSDisk
    osdisk_name     = "eus-central-hub-dnsbind-vm01_OsDisk_1"
    osdisk_caching  = "ReadWrite"
    osdisk_type     = "Standard_LRS"
    os_disk_size_gb = "30"

    #Data disks
    data_disks = []

    #deleteDisk #this line to delete the OS disk and data disk automatically when deleting the VM if it's true
    delete_os_disk_on_termination    = true #default it is "true"
    delete_data_disks_on_termination = true #default it is "false"

    #osprofile
    computer_name  = "eus-hub-central-dns-vm-01"
    admin_usename  = "dnsadmin"
    admin_password = "dnsadmin@123"

    disable_password_authentication = false #Specifies whether password authentication should be disabled. If set to "false", an "admin_password" must be specified. by default it is true
  },

  vm2 = {
    virtualmachine_name        = "eus-hub-central-dns-vm-01"
    vm_size                    = "Standard_D2s_v3"
    vm_vnet_name               = "eus-hub-central-vnet-01"
    vm_subnet_name             = "eus-hub-snet-compute-p-01"
    subnet_resource_group_name = "eus-hub-central-rg"

    #NIC
    vm_nic_name                   = "eus-hub-central-dns-569"
    ip_config_name                = "ipconfig1"
    private_ip_address_allocation = "Dynamic"


    #storage_image_reference
    image_publisher = "Canonical"
    image_offer     = "UbuntuServer"
    image_sku       = "18.04-LTS"
    image_version   = "latest"

    #OSDisk
    osdisk_name     = "eus-central-hub-dnsbind-vm01"
    osdisk_caching  = "ReadWrite"
    osdisk_type     = "Premium_LRS"
    os_disk_size_gb = "30"

    data_disks = []

    #deleteDisk #this line to delete the OS disk and data disk automatically when deleting the VM if it's true
    delete_os_disk_on_termination    = true #default it is "true"
    delete_data_disks_on_termination = true #default it is "false"

    #osprofile
    computer_name  = "eus-hub-central-dns-vm-01"
    admin_usename  = "dnsadmin"
    admin_password = "dnsadmin@123"

    disable_password_authentication = false #Specifies whether password authentication should be disabled. If set to "false", an "admin_password" must be specified. by default it is true
  }
}

#Virtual Machine Scale Set
vmss = {
  vmss1 = {
    vmss_name                  = "eus-central-hub-dnsbind-vmss01"
    vmss_size                  = "Standard_D2s_v3"
    vmss_vnet_name             = "eus-hub-central-vnet-01"
    vmss_subnet_name           = "eus-hub-snet-vmss-p-01"
    subnet_resource_group_name = "eus-hub-central-rg"
    vmss_instances             = 1

    #NIC
    vmss_nic_name  = "eus-hub-central-vnet-01-nic01"
    ip_config_name = "eus-hub-central-vnet-01-nic01-defaultIpConfiguration"

    #storage_image_reference
    image_publisher = "Canonical"
    image_offer     = "UbuntuServer"
    image_sku       = "18.04-LTS"
    image_version   = "latest"

    #OSDisk
    osdisk_caching  = "ReadWrite"
    osdisk_type     = "StandardSSD_LRS"
    os_disk_size_gb = "30"

    #osprofile
    computer_name_prefix = "eus-centr"
    admin_usename        = "dnsadmin"
    admin_password       = "dnsadmin@123"

    #autoscale
    autoscale_name     = "eus-central-hub-dnsbind-vmss01-Autoscale-475"
    min_capacity       = 1
    max_capacity       = 10
    metric_name        = "Percentage CPU"
    scaleout_threshold = 80
    scalein_threshold  = 80

  }
}

###############################################################################################################################################################################################################

###############################################################################################################################################################################################################

#Central Hub Virtual-Machine Resource Group
centralhub_virtualmachine_rg = "eus-hub-central-UAT-virtualmachine-rg" #"eus-hub-central-virtualmachine-rg"

#NSG
virtualmachine_rg_nsgs = {
  nsg1 = {
    nsg_name = "Virtual-Machine-CHUB-UAT-nsg" #"Virtual-Machine-CHUB-nsg"

    nsg_rules = [
      {
        name                                       = "AllowAnyHTTPSInbound"
        description                                = null
        priority                                   = 100
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "Tcp"
        source_port_range                          = "*"
        source_port_ranges                         = []
        destination_port_range                     = "443"
        destination_port_ranges                    = []
        source_address_prefix                      = "*"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
      },
      {
        name                                       = "open-port-443"
        description                                = null
        priority                                   = 900
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "Udp"
        source_port_range                          = "*"
        source_port_ranges                         = []
        destination_port_range                     = "443"
        destination_port_ranges                    = []
        source_address_prefix                      = "*"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
      },
    ]
  }
}

#Virtaul Machine
virtualmachine_rg_vms = {
  vm1 = {
    virtualmachine_name        = "Virtual-Machine-CHUB"
    vm_size                    = "Standard_B2ms"
    vm_vnet_name               = "eus-hub-central-vnet-01"
    vm_subnet_name             = "subnetvm"
    subnet_resource_group_name = "eus-hub-central-rg"

    #NIC
    vm_nic_name                   = "virtual-machine-c480"
    ip_config_name                = "ipconfig1"
    private_ip_address_allocation = "Dynamic"

    #storage_image_reference
    image_publisher = "MicrosoftWindowsServer"
    image_offer     = "WindowsServer"
    image_sku       = "2019-datacenter-gensecond"
    image_version   = "latest"

    #OSDisk
    osdisk_name     = "Virtual-Machine-CHUB_disk1"
    osdisk_caching  = "ReadWrite"
    osdisk_type     = "Standard_LRS"
    os_disk_size_gb = "127"

    #Data disks
    data_disks = []

    #deleteDisk #this line to delete the OS disk and data disk automatically when deleting the VM if it's true
    delete_os_disk_on_termination    = true #default it is "true"
    delete_data_disks_on_termination = true #default it is "false"

    #osprofile
    computer_name  = "Virtual-Machine"
    admin_usename  = "dnsadmin"
    admin_password = "dnsadmin@123"
  }
}

##########################################################################################################################################################################

##########################################################################################################################################################################

#Central Hub PROD Resource Group
centralhub_prod_rg = "eus-hub-central-prod-rg"

# Storage Accounts
centralhub_prod_storageaccount = ["eushubcentralprodrgdiag"]
centralhub_prod_containers_list = [
  { name = "vpntroubleshoot", access_type = "private" },
  { name = "certs", access_type = "private" },
  { name = "insights-metrics-pt1m", access_type = "private" },
  { name = "insights-logs-applicationgatewayaccesslog", access_type = "private" },
  { name = "insights-logs-applicationgatewayfirewalllog", access_type = "private" },
  { name = "insights-logs-applicationgatewayperformancelog", access_type = "private" }
]

#Application Insught
centralhub_prod_applicationinsightsname = "eus-prod-chub-apim-ai"

#Application Gateway
centralhub_prod_applicationgateway_name = "eus-hub-central-prod-agw-01"

#ServiceBus Namespace
centralhub_prod_servicebus_namespace_name = "eus-hub-central-prod-sb-01"

#API Management Service
centralhub_prod_api_management_service_name = "eus-hub-central-prod-apim-01"

#NSG
centralhub_prod_nsgs = {
  nsg1 = {
    nsg_name = "eus-p-hub-vm-01-nsg"

    nsg_rules = [
      {
        name                                       = "Port_443_IB"
        description                                = null
        priority                                   = 1000
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        source_port_ranges                         = []
        destination_port_range                     = "443"
        destination_port_ranges                    = []
        source_address_prefix                      = "*"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
      },
      {
        name                                       = "Port_80_IB"
        description                                = null
        priority                                   = 1002
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        source_port_ranges                         = []
        destination_port_range                     = "80"
        destination_port_ranges                    = []
        source_address_prefix                      = "*"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
      },
      {
        name                                       = "Port_8080_IB"
        description                                = null
        priority                                   = 1004
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        source_port_ranges                         = []
        destination_port_range                     = "8080"
        destination_port_ranges                    = []
        source_address_prefix                      = "*"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
      },
      {
        name                                       = "Port_65503to65534_IB"
        description                                = null
        priority                                   = 1006
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        source_port_ranges                         = []
        destination_port_range                     = "65503-65534"
        destination_port_ranges                    = []
        source_address_prefix                      = "*"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
      },
      {
        name                                       = "Port_3443_APIEndPoint"
        description                                = null
        priority                                   = 1008
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        source_port_ranges                         = []
        destination_port_range                     = "3443"
        destination_port_ranges                    = []
        source_address_prefix                      = "*"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
      },
      {
        name                                       = "Port_6381to6383_IB"
        description                                = null
        priority                                   = 1011
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        source_port_ranges                         = []
        destination_port_range                     = "6381-6383"
        destination_port_ranges                    = []
        source_address_prefix                      = "*"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
      },
      {
        name                                       = "Port_443_OB"
        description                                = null
        priority                                   = 1001
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        source_port_ranges                         = []
        destination_port_range                     = "443"
        destination_port_ranges                    = []
        source_address_prefix                      = "*"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
      },
      {
        name                                       = "Port_80_OB"
        description                                = null
        priority                                   = 1003
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        source_port_ranges                         = []
        destination_port_range                     = "80"
        destination_port_ranges                    = []
        source_address_prefix                      = "*"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
      },
      {
        name                                       = "Port_8080_OB"
        description                                = null
        priority                                   = 1005
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        source_port_ranges                         = []
        destination_port_range                     = "8080"
        destination_port_ranges                    = []
        source_address_prefix                      = "*"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
      },
      {
        name                                       = "Port_65503to65534_OB"
        description                                = null
        priority                                   = 1007
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        source_port_ranges                         = []
        destination_port_range                     = "65503-65534"
        destination_port_ranges                    = []
        source_address_prefix                      = "*"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
      },
      {
        name                                       = "Port_25_OB"
        description                                = null
        priority                                   = 1009
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        source_port_ranges                         = []
        destination_port_range                     = "25"
        destination_port_ranges                    = []
        source_address_prefix                      = "*"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
      },
      {
        name                                       = "Port_587_OB"
        description                                = null
        priority                                   = 1010
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        source_port_ranges                         = []
        destination_port_range                     = "587"
        destination_port_ranges                    = []
        source_address_prefix                      = "*"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
      },
      {
        name                                       = "Port_25028"
        description                                = null
        priority                                   = 1012
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        source_port_ranges                         = []
        destination_port_range                     = "25028"
        destination_port_ranges                    = []
        source_address_prefix                      = "*"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
      },
      {
        name                                       = "Port_6381to6383"
        description                                = null
        priority                                   = 1013
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        source_port_ranges                         = []
        destination_port_range                     = "6381-6383"
        destination_port_ranges                    = []
        source_address_prefix                      = "*"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
      },
      {
        name                                       = "Port_1886_OB"
        description                                = null
        priority                                   = 1014
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        source_port_ranges                         = []
        destination_port_range                     = "1886"
        destination_port_ranges                    = []
        source_address_prefix                      = "*"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
      },
      {
        name                                       = "Port_445_Storage_OB"
        description                                = null
        priority                                   = 1015
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        source_port_ranges                         = []
        destination_port_range                     = "445"
        destination_port_ranges                    = []
        source_address_prefix                      = "*"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
      },
      {
        name                                       = "Port_5672_EH_OB"
        description                                = null
        priority                                   = 1016
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        source_port_ranges                         = []
        destination_port_range                     = "5672"
        destination_port_ranges                    = []
        source_address_prefix                      = "*"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
      },
    ]
  }
}

#Public IP
centralhub_prod_publicIps = {
  publicIp1 = {
    public_ip_name     = "eus-hub-central-prod-agw-pip-01"
    allocation_method  = "Dynamic"
    public_ip_sku      = "Basic"
    public_ip_sku_tier = "Regional"
  }
}


##########################################################################################################################################################################

##########################################################################################################################################################################

#Central Hub SIT Resource Group
centralhub_sit_rg = "eus-hub-central-sit-rg"

# Storage Accounts
centralhub_sit_storageaccount = ["eushubstgacc4logs01"]
centralhub_sit_containers_list = [
  { name = "backup", access_type = "container" },
  { name = "insights-logs-applicationgatewayaccesslog", access_type = "private" },
  { name = "insights-logs-applicationgatewayfirewalllog", access_type = "private" },
  { name = "insights-logs-applicationgatewayperformancelog", access_type = "private" },
  { name = "insights-logs-gatewaydiagnosticlog", access_type = "private" },
  { name = "insights-logs-gatewaylogs", access_type = "private" },
  { name = "insights-logs-networksecuritygroupflowevent", access_type = "private" },
  { name = "insights-logs-routediagnosticlog", access_type = "private" },
  { name = "insights-logs-tunneldiagnosticlog", access_type = "private" },
  { name = "insights-metrics-pt1m", access_type = "private" }
]

#Application Insight
centralhub_sit_applicationinsightsname = "eus-hub-apim-sit-ai"

#Application Gateway
centralhub_sit_applicationgateway_name = "eus-hub-central-sit-agw-01"

#ServiceBus Namespace
centralhub_sit_servicebus_namespace_name = "eus-hub-central-nonprod-sit-sb-01"

#API Management Service
centralhub_sit_api_management_service_name = "eus-hub-central-nonprod-sit-apim-01"

#NSG
centralhub_sit_nsgs = {
  nsg1 = {
    nsg_name = "eus-s-hub-vm-01-nsg"

    nsg_rules = [
      {
        name                                       = "Port_443_IB"
        description                                = null
        priority                                   = 100
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        source_port_ranges                         = []
        destination_port_range                     = "443"
        destination_port_ranges                    = []
        source_address_prefix                      = "*"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
      },
      {
        name                                       = "Port_80_IB"
        description                                = null
        priority                                   = 101
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        source_port_ranges                         = []
        destination_port_range                     = "80"
        destination_port_ranges                    = []
        source_address_prefix                      = "*"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
      },
      {
        name                                       = "Port_8080_IB"
        description                                = null
        priority                                   = 102
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        source_port_ranges                         = []
        destination_port_range                     = "8080"
        destination_port_ranges                    = []
        source_address_prefix                      = "*"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
      },
      {
        name                                       = "Port_65503to65534_IB"
        description                                = null
        priority                                   = 103
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        source_port_ranges                         = []
        destination_port_range                     = "65503-65534"
        destination_port_ranges                    = []
        source_address_prefix                      = "*"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
      },
      {
        name                                       = "Port_3443_APIEndPoint"
        description                                = null
        priority                                   = 104
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        source_port_ranges                         = []
        destination_port_range                     = "3443"
        destination_port_ranges                    = []
        source_address_prefix                      = "*"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
      },
      {
        name                                       = "Port_6381to6383_IB"
        description                                = null
        priority                                   = 105
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        source_port_ranges                         = []
        destination_port_range                     = "6381-6383"
        destination_port_ranges                    = []
        source_address_prefix                      = "*"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
      },
      {
        name                                       = "Port_443_OB"
        description                                = null
        priority                                   = 100
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        source_port_ranges                         = []
        destination_port_range                     = "443"
        destination_port_ranges                    = []
        source_address_prefix                      = "*"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
      },
      {
        name                                       = "Port_80_OB"
        description                                = null
        priority                                   = 101
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        source_port_ranges                         = []
        destination_port_range                     = "80"
        destination_port_ranges                    = []
        source_address_prefix                      = "*"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
      },
      {
        name                                       = "Port_8080_OB"
        description                                = null
        priority                                   = 102
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        source_port_ranges                         = []
        destination_port_range                     = "8080"
        destination_port_ranges                    = []
        source_address_prefix                      = "*"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
      },
      {
        name                                       = "Port_65503to65534_OB"
        description                                = null
        priority                                   = 103
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        source_port_ranges                         = []
        destination_port_range                     = "65503-65534"
        destination_port_ranges                    = []
        source_address_prefix                      = "*"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
      },
      {
        name                                       = "Port_25_OB"
        description                                = null
        priority                                   = 104
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        source_port_ranges                         = []
        destination_port_range                     = "25"
        destination_port_ranges                    = []
        source_address_prefix                      = "*"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
      },
      {
        name                                       = "Port_587_OB"
        description                                = null
        priority                                   = 105
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        source_port_ranges                         = []
        destination_port_range                     = "587"
        destination_port_ranges                    = []
        source_address_prefix                      = "*"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
      },
      {
        name                                       = "Port_25028"
        description                                = null
        priority                                   = 106
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        source_port_ranges                         = []
        destination_port_range                     = "25028"
        destination_port_ranges                    = []
        source_address_prefix                      = "*"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
      },
      {
        name                                       = "Port_6381to6383"
        description                                = null
        priority                                   = 107
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        source_port_ranges                         = []
        destination_port_range                     = "6381-6383"
        destination_port_ranges                    = []
        source_address_prefix                      = "*"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
      },
      {
        name                                       = "Port_1886_OB"
        description                                = null
        priority                                   = 108
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        source_port_ranges                         = []
        destination_port_range                     = "1886"
        destination_port_ranges                    = []
        source_address_prefix                      = "*"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
      },
      {
        name                                       = "Port_445_Storage_OB"
        description                                = null
        priority                                   = 109
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        source_port_ranges                         = []
        destination_port_range                     = "445"
        destination_port_ranges                    = []
        source_address_prefix                      = "*"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
      },
      {
        name                                       = "Port_5672_EH_OB"
        description                                = null
        priority                                   = 1010
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "*"
        source_port_range                          = "*"
        source_port_ranges                         = []
        destination_port_range                     = "5672"
        destination_port_ranges                    = []
        source_address_prefix                      = "*"
        source_address_prefixes                    = []
        source_application_security_group_ids      = []
        destination_address_prefix                 = "*"
        destination_address_prefixes               = []
        destination_application_security_group_ids = []
      },
    ]
  }
}

#Public IP
centralhub_sit_publicIps = {
  publicIp1 = {
    public_ip_name     = "eus-hub-central-sit-agw-pip-01"
    allocation_method  = "Dynamic"
    public_ip_sku      = "Basic"
    public_ip_sku_tier = "Regional"
  }
}

