module "ResourceGroup" {

  source            = "../../modules/ResourceGroup"
  resourcegroupname = var.resourcegroupname
  location          = var.location
  tags              = var.tags

}


module "VirtualNetwork" {

  depends_on = [
    module.ResourceGroup
  ]

  source            =   "../../modules/VirtualNetwork"
  resourcegroupname =   var.resourcegroupname
  location            = var.location
  vnet_name           = var.vnet_name
  address_space       = var.address_space
  subnets = [
    {
      name : var.subnet_name
      address_prefixes : var.address_prefixes
    }
  ]
}

module "WindowsVirtualMachine" {

  depends_on = [
    module.ResourceGroup,
    module.VirtualNetwork
  ]

  for_each                   = var.vms
  source                     = "../../modules/WindowsVirtualMachine"
  location                   = var.location
  resourcegroupname          = var.resourcegroupname
  subnet_resource_group_name = each.value["subnet_resource_group_name"]
  virtualmachine_name        = each.value["virtualmachine_name"]
  vm_size                    = each.value["vm_size"]
  virtual_network_name       = each.value["vm_vnet_name"]
  subnet_name                = each.value["vm_subnet_name"]

  vm_nic_name                   = each.value["vm_nic_name"]
  ip_config_name                = each.value["ip_config_name"]
  private_ip_address_allocation = lookup(each.value, "private_ip_address_allocation", "Dynamic")

  image_publisher = each.value["image_publisher"]
  image_offer     = each.value["image_offer"]
  image_sku       = each.value["image_sku"]
  image_version   = lookup(each.value, "image_version", "latest")

  osdisk_name     = each.value["osdisk_name"]
  osdisk_caching  = lookup(each.value, "osdisk_caching", "ReadWrite")
  os_disk_type    = each.value["osdisk_type"]
  os_disk_size_gb = each.value["os_disk_size_gb"]

  data_disks = lookup(each.value, "data_disks", [])

  computer_name  = lookup(each.value, "computer_name", "Virtual-Machine")
  admin_usename  = each.value["admin_usename"]
  admin_password = lookup(each.value, "admin_password", null)

  tags = var.tags

  #deleteDisks. This line to delete the OS disk and data disk automatically when deleting the VM if it's "true"
  delete_os_disk_on_termination    = lookup(each.value, "delete_os_disk_on_termination", true)
  delete_data_disks_on_termination = lookup(each.value, "delete_data_disks_on_termination", false)

}

module "NetworkSecurityGroup" {

  depends_on = [
    module.ResourceGroup
  ]

  for_each          = var.nsgs
  source            = "../../modules/NetworkSecurityGroup"
  location          = var.location
  resourcegroupname = var.resourcegroupname
  nsg_name          = each.value["nsg_name"]
  tags              = var.tags

  nsg_rules = lookup(each.value, "nsg_rules", [])

}
