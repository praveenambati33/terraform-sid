#Virtual Machine
vms = {
    vm1 = {
        virtualmachine_name = "eus-central-hub-dnsbind-vm01"
        vm_size             = "Standard_D2s_v3"
        vm_vnet_name        = "eus-hub-central-vnet-01"
        vm_subnet_name      = "eus-hub-snet-vmss-p-01"
        # address_prefixes    = "172.30.5.0/28"  #uncomment this if you creating VM subnet with VM and provide Subent address prefixes

        #NIC
        vm_nic_name         = "eus-central-hub-dnsb777"
        ip_config_name      = "ipconfig1"
        private_ip_address_allocation = "Dynamic"  #Default = "Dynamic"

        #storage_image_reference
        image_publisher     = "Canonical"
        image_offer         = "UbuntuServer"
        image_sku           = "16.04-LTS"
        image_version       = "latest"   #Defualt = "latest"

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
        delete_os_disk_on_termination = true  #default it is "true"
        delete_data_disks_on_termination = true  #default it is "false"

        #osprofile
        admin_usename = "dnsadmin"
        admin_password = "dnsadmin@123"

        disable_password_authentication = false  #Specifies whether password authentication should be disabled. If set to "false", an "admin_password" must be specified. by default it is true
    },

    vm2 = {
        virtualmachine_name = "eus-hub-central-dns-vm-01"
        vm_size             = "Standard_D2s_v3"
        vm_vnet_name        = "eus-hub-central-vnet-01"
        vm_subnet_name      = "eus-hub-snet-compute-p-01"
        # address_prefixes    = "172.30.5.0/28"  #uncomment this if you creating VM subnet with VM and provide Subent address prefixes

        #NIC
        vm_nic_name         = "eus-hub-central-dns-569"
        ip_config_name      = "ipconfig1"
        private_ip_address_allocation = "Dynamic"               #Default = "Dynamic"


        #storage_image_reference
        image_publisher     = "Canonical"
        image_offer         = "UbuntuServer"
        image_sku           = "18.04-LTS"
        image_version       = "latest"                           #Defualt = "latest"

        #OSDisk
        osdisk_name         = "eus-central-hub-dnsbind-vm01_OsDisk_1"
        osdisk_caching      = "ReadWrite"
        osdisk_type         = "Premium_LRS"
        os_disk_size_gb     = "30"

        data_disks = []    #Keep blank if there is no data disk

        #deleteDisk #this line to delete the OS disk and data disk automatically when deleting the VM if it's true
        delete_os_disk_on_termination = true  #default it is "true"
        delete_data_disks_on_termination = true  #default it is "false"

        #osprofile
        admin_usename = "dnsadmin"
        admin_password = "dnsadmin@123"

        disable_password_authentication = false  #Specifies whether password authentication should be disabled. If set to "false", an "admin_password" must be specified. by default it is true
    }
}