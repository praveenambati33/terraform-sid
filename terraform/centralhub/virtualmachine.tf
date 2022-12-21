#Virtual machine
module "CHub_VM" {

  depends_on                    = [module.CHub_vnet,module.CHub_subnet]
  for_each                      = var.vms
  source                        = "./modules/VirtualMachine"
  location                      = var.location
  resource_group_name           = var.centralhub_resourcegroupname
  virtualmachine_name           = each.value["virtualmachine_name"]
  vm_size                       = each.value["vm_size"]
  virtual_network_name          = each.value["vm_vnet_name"]
  subnet_name                   = each.value["vm_subnet_name"]
  address_prefixes              = each.value["address_prefixes"]  #uncomment this if you creating VM subnet with VM

  vm_nic_name                   = each.value["vm_nic_name"]
  ip_config_name                = each.value["ip_config_name"]
  private_ip_address_allocation = lookup(each.value, "private_ip_address_allocation", "Dynamic")

  image_publisher               = each.value["image_publisher"]
  image_offer                   = each.value["image_offer"]
  image_sku                     = each.value["image_sku"]
  image_version                 = lookup(each.value, "image_version", "latest")

  osdisk_name                   = each.value["osdisk_name"]
  osdisk_caching                = lookup(each.value, "osdisk_caching", "ReadWrite")
  os_disk_type                  = each.value["osdisk_type"]
  os_disk_size_gb               = each.value["os_disk_size_gb"]

  data_disks                    = lookup(each.value, "data_disks", [])

  admin_usename                 = each.value["admin_usename"]
  admin_password                = lookup(each.value, "admin_password", null)

  tags                          = var.tags

  #deleteDisks. This line to delete the OS disk and data disk automatically when deleting the VM if it's "true"
  delete_os_disk_on_termination     = lookup(each.value, "delete_os_disk_on_termination", true)             #default it is "true"
  delete_data_disks_on_termination  = lookup(each.value, "delete_data_disks_on_termination", false)      #default it is "false"

  disable_password_authentication   = lookup(each.value, "disable_password_authentication", true) #Specifies whether password authentication should be disabled. If set to "false", an "admin_password" must be specified. by default it is true

}


#virtualmachine_rg VMs
module "virtualmachine_rg_VM" {

  depends_on                    = [module.CHub_vnet,module.CHub_subnet]
  for_each                      = var.vms
  source                        = "./modules/VirtualMachine"
  location                      = var.location
  resource_group_name           = var.centralhub_virtualmachine_rg
  virtualmachine_name           = each.value["virtualmachine_name"]
  vm_size                       = each.value["vm_size"]
  virtual_network_name          = each.value["vm_vnet_name"]
  subnet_name                   = each.value["vm_subnet_name"]
  address_prefixes              = each.value["address_prefixes"]  #uncomment this if you creating VM subnet with VM

  vm_nic_name                   = each.value["vm_nic_name"]
  ip_config_name                = each.value["ip_config_name"]
  private_ip_address_allocation = lookup(each.value, "private_ip_address_allocation", "Dynamic")

  image_publisher               = each.value["image_publisher"]
  image_offer                   = each.value["image_offer"]
  image_sku                     = each.value["image_sku"]
  image_version                 = lookup(each.value, "image_version", "latest")

  osdisk_name                   = each.value["osdisk_name"]
  osdisk_caching                = lookup(each.value, "osdisk_caching", "ReadWrite")
  os_disk_type                  = each.value["osdisk_type"]
  os_disk_size_gb               = each.value["os_disk_size_gb"]

  data_disks                    = lookup(each.value, "data_disks", [])

  admin_usename                 = each.value["admin_usename"]
  admin_password                = lookup(each.value, "admin_password", null)

  tags                          = var.tags

  #deleteDisks. This line to delete the OS disk and data disk automatically when deleting the VM if it's "true"
  delete_os_disk_on_termination     = lookup(each.value, "delete_os_disk_on_termination", true)             #default it is "true"
  delete_data_disks_on_termination  = lookup(each.value, "delete_data_disks_on_termination", false)      #default it is "false"

  disable_password_authentication   = lookup(each.value, "disable_password_authentication", true) #Specifies whether password authentication should be disabled. If set to "false", an "admin_password" must be specified. by default it is true

}