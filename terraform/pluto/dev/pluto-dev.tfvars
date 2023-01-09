#Resource Group
resourcegroupname = "eus-perf-pluto-rg"
location          = "eastus"

vnet_name = "pluto-vnet"
address_space = ["10.0.0.0/22"]
subnet_name = "pluto-app-subnet"
address_prefixes = ["10.0.1.0/24"]

# Virtual Machine
vms = {
  vm1 = {
    virtualmachine_name        = "pluto-app-vm-01"
    vm_size                    = "Standard_D4s_v3"
    vm_vnet_name               = "pluto-vnet"
    vm_subnet_name             = "pluto-app-subnet"
    subnet_resource_group_name = "eus-perf-pluto-rg"

    #NIC
    vm_nic_name                   = "pluto-vm-nic-001"
    ip_config_name                = "ipconfig1"
    private_ip_address_allocation = "Dynamic"

    #storage_image_reference
    image_publisher = "MicrosoftWindowsServer"
    image_offer     = "WindowsServer"
    image_sku       = "2016-Datacenter"
    image_version   = "latest"

    #OSDisk
    osdisk_name     = "pluto-vm-osdisk-001"
    osdisk_caching  = "ReadWrite"
    osdisk_type     = "Standard_LRS"
    os_disk_size_gb = "127"

    #Data disks
    data_disks = []

    #deleteDisk #this line to delete the OS disk and data disk automatically when deleting the VM if it's true
    delete_os_disk_on_termination    = true #default it is "true"
    delete_data_disks_on_termination = true #default it is "false"

    #osprofile
    computer_name  = "plutuappvm001"
    admin_usename  = "plutoadmin"
    admin_password = "admin@123"
  }
}

nsgs = {
  nsg1 = {
    nsg_name = "pluto-app-vm-nsg"

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
      },
      {
        name                                       = "HTTP"
        description                                = null
        priority                                   = 322
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "Tcp"
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
      }
    ]
    
  }
}


tags = {
  "Application Name" = "test"
  "applicationType"  = "app"
  "Dept Id"          = "111"
  "Environment"      = "dev"
}