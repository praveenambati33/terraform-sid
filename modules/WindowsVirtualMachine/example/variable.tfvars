#Virtual Machine #Need to change some values
vms = {
    vm1 = {
        virtualmachine_name = "eus-central-hub-dnsbind-vm01"
        vm_size             = "Standard_D2s_v3"
        vm_vnet_name        = "eus-hub-central-vnet-01"
        vm_subnet_name      = "eus-hub-snet-vmss-p-01"
        subnet_resource_group_name  = "eus-hub-central-rg"

        #NIC
        vm_nic_name         = "eus-central-hub-dnsb777"
        ip_config_name      = "ipconfig1"
        private_ip_address_allocation = "Dynamic"                                       #Default = "Dynamic"

        #storage_image_reference
        image_publisher     = "Canonical"
        image_offer         = "UbuntuServer"
        image_sku           = "16.04-LTS"
        image_version       = "latest"                                                  #Defualt = "latest"

        #OSDisk
        osdisk_name         = "eus-central-hub-dnsbind-vm01_OsDisk_1"
        osdisk_caching      = "ReadWrite"
        osdisk_type         = "Standard_LRS"
        os_disk_size_gb     = "30"
        
        #Data disks
        data_disks = [                                                                  #Keep blank if there is no data disk
            {
                managed_data_disk_name  = "eus-central-hub-dnsbind-vm01_dataDisk_01"
                disk_size_gb            = "20"
                managed_disk_type       = "Standard_LRS"
            },

            {
                managed_data_disk_name = "eus-central-hub-dnsbind-vm01_dataDisk_02"
                disk_size_gb           = "30"
                managed_disk_type      = "Standard_LRS"
            }
        ]

        #deleteDisk #this line to delete the OS disk and data disk automatically when deleting the VM if it's true
        delete_os_disk_on_termination       = true                      #default it is "true"
        delete_data_disks_on_termination    = true                      #default it is "false"

        #osprofile
        computer_name       = "Virtual-Machine"
        admin_usename       = "dnsadmin"
        admin_password      = "dnsadmin@123"            
    },

    vm1 = {
        virtualmachine_name         = "Virtual-Machine-CHUB"
        vm_size                     = "Standard_B2ms"
        vm_vnet_name                = "eus-hub-central-vnet-01"
        vm_subnet_name              = "subnetvm"
        subnet_resource_group_name  = "eus-hub-central-rg"

        #NIC
        vm_nic_name                 = "virtual-machine-c480"
        ip_config_name              = "ipconfig1"
        private_ip_address_allocation = "Dynamic"                                       #Default = "Dynamic"

        #storage_image_reference
        image_publisher             = "MicrosoftWindowsServer"                          
        image_offer                 = "WindowsServer"
        image_sku                   = "2019-datacenter-gensecond"
        image_version               = "latest"                                          #Defualt = "latest"

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
        computer_name       = "Virtual-Machine"
        admin_usename       = "dnsadmin"
        admin_password      = "dnsadmin@123"            
    }
}