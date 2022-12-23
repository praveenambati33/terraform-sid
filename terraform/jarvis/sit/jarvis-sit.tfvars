#Resource Group
resourcegroupname = "eus-perf-jarvis-virassnt-rg"
location          = "eastus"

# Storage Account for App Service and App logs
storage_list    = ["hphcperfvastorage"]
containers_list = []

applicationinsightsname = "HPHCPERFVAReporting"

#ServicePlan
serviceplanname = "ASP-eusjarvisperfvirassntrg-a4f6"
ostype          = "Windows"
sku             = "Y1"

# Function Application
functionappname = "HPHCPERFVAReporting"
stack_version   = { dotnet = "3.1" }

#Application Configuration
function_app_application_settings = {

  "AzureWebJo6bsStorage" = "DefaultEndpointsProtocol=https;AccountName=hphcvastorage;AccountKey=cH599A/qwTxAxRtSWeSI49r3+s622q1i6mmQLVpfO2IHO8O6rRQ6fy8/a7mLiWV+7mKaSshVCanN10Mvi0riCA==;EndpointSuffix=core.windows.net"

}

# Key vault to secure the application sensitive information
keyvaultname = "HPHCVAPERFKeyVault"

hphcappservicename           = "hphcvaperf"
hphc_serviceplanname         = "HPHCVAperf"
hphc_applicationinsightsname = "HPHCVAperf3zbkz"
hphc_stack_version           = { dotnet = "v4.0" }
hphc_sku                     = "S1"
#Application Configuration
app_settings = {

  "AzureWebJo6bsStorage" = "DefaultEndpointsProtocol=https;AccountName=hphcvastorage;AccountKey=cH599A/qwTxAxRtSWeSI49r3+s622q1i6mmQLVpfO2IHO8O6rRQ6fy8/a7mLiWV+7mKaSshVCanN10Mvi0riCA==;EndpointSuffix=core.windows.net"

}

#NSG
nsgs = {
  nsg1 = {
    nsg_name = "eus-s-jarvis-vm-nsg"

    nsg_rules = [
      {
        name                                       = "HTTPS"
        description                                = null
        priority                                   = 320
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
      }
    ]
    
  }
}

# Virtual Machine
vms = {
  vm1 = {
    virtualmachine_name        = "eus-s-jarvis-vm"
    vm_size                    = "Standard_D4s_v3"
    vm_vnet_name               = "eus-s-vnet"
    vm_subnet_name             = "eus-jarvisvm-snet"
    subnet_resource_group_name = "eus-s-network-rg"

    #NIC
    vm_nic_name                   = "eus-s-jarvis-vm774"
    ip_config_name                = "ipconfig1"
    private_ip_address_allocation = "Dynamic"

    #storage_image_reference
    image_publisher = "MicrosoftWindowsServer"
    image_offer     = "WindowsServer"
    image_sku       = "2016-Datacenter"
    image_version   = "latest"

    #OSDisk
    osdisk_name     = "eus-s-jarvis-vm_disk1"
    osdisk_caching  = "ReadWrite"
    osdisk_type     = "Standard_LRS"
    os_disk_size_gb = "127"

    #Data disks
    data_disks = []

    #deleteDisk #this line to delete the OS disk and data disk automatically when deleting the VM if it's true
    delete_os_disk_on_termination    = true #default it is "true"
    delete_data_disks_on_termination = true #default it is "false"

    #osprofile
    computer_name  = "eus-s-jarvis-vm"
    admin_usename  = "chatbotadmin"
    admin_password = "admin@123"
  }
}


tags = {
  "Application Name" = "jarvis"
  "applicationType"  = "serverless-jarvis"
  "Dept Id"          = "411"
  "Environment"      = "Ent SIT2"
}
