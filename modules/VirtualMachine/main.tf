#Uncomment this block if you want to created Subnet of VM with subnet only
resource "azurerm_subnet" "vm_subnet" {

  name                    = var.subnet_name
  resource_group_name     = var.resource_group_name
  virtual_network_name    = var.virtual_network_name
  address_prefixes        = var.address_prefixes

}

#Uncomment this block if you have already created Subnet of VM
# data "azurerm_subnet" "vm_subnet" {

#   name                    = var.subnet_name
#   virtual_network_name    = var.virtual_network_name
#   resource_group_name     = var.resource_group_name

# }

resource "azurerm_network_interface" "nic" {

  name                              = var.vm_nic_name
  location                          = var.location
  resource_group_name               = var.resource_group_name

  ip_configuration {
    name                            = var.ip_config_name
    subnet_id                       = azurerm_subnet.vm_subnet.id           #Uncomment this if you want Subnet with VM
    # subnet_id                     = data.azurerm_subnet.vm_subnet.id      #Uncomment this if you have created subnet already.
    private_ip_address_allocation   = var.private_ip_address_allocation 
  }

}

resource "azurerm_virtual_machine" "virtualmachine" {

  depends_on                        = [azurerm_network_interface.nic,azurerm_subnet.vm_subnet]
  name                              = var.virtualmachine_name          
  location                          = var.location
  resource_group_name               = var.resource_group_name
  network_interface_ids             = [azurerm_network_interface.nic.id]
  vm_size                           = var.vm_size

  delete_os_disk_on_termination     = var.delete_os_disk_on_termination         # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_data_disks_on_termination  = var.delete_data_disks_on_termination      # Uncomment this line to delete the data disks automatically when deleting the VM

  storage_image_reference {
    publisher                       = var.image_publisher
    offer                           = var.image_offer
    sku                             = var.image_sku
    version                         = var.image_version
  }

  storage_os_disk {
    name                            = var.osdisk_name
    caching                         = var.osdisk_caching
    create_option                   = "FromImage"
    managed_disk_type               = var.os_disk_type
    disk_size_gb                    = var.os_disk_size_gb
  }

  dynamic "storage_data_disk" {
    for_each = var.data_disks

    content {
      name                          = storage_data_disk.value["managed_data_disk_name"]
      create_option                 = "Empty"
      lun                           = 0
      disk_size_gb                  = storage_data_disk.value["disk_size_gb"]
      managed_disk_type             = storage_data_disk.value["managed_disk_type"]
    }
  }

  os_profile {
    computer_name                   = var.virtualmachine_name   #local.vm_name
    admin_username                  = var.admin_usename
    admin_password                  = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = var.disable_password_authentication
  }
}