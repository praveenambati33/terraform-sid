# #Central Hub Central RG

# #Virtual Machine Scale Set
# module "vmss" {

#   depends_on                 = [module.CHub_vnet, module.CHub_subnet]
#   for_each                   = var.vmss
#   source                     = "./modules/VirtualMachineScaleSet"
#   location                   = var.location
#   resourcegroupname          = var.centralhub_resourcegroupname
#   subnet_resource_group_name = each.value["subnet_resource_group_name"]
#   virtual_network_name       = each.value["vmss_vnet_name"]
#   subnet_name                = each.value["vmss_subnet_name"]
#   vmss_name                  = each.value["vmss_name"]
#   vmss_size                  = each.value["vmss_size"]
#   vmss_instances             = each.value["vmss_instances"]

#   vmss_nic_name  = each.value["vmss_nic_name"]
#   ip_config_name = each.value["ip_config_name"]

#   image_publisher = each.value["image_publisher"]
#   image_offer     = each.value["image_offer"]
#   image_sku       = each.value["image_sku"]
#   image_version   = lookup(each.value, "image_version", "latest")

#   osdisk_caching  = lookup(each.value, "osdisk_caching", "ReadWrite")
#   os_disk_type    = each.value["osdisk_type"]
#   os_disk_size_gb = each.value["os_disk_size_gb"]

#   computer_name_prefix = lookup(each.value, "computer_name_prefix", "Virtual-Machine-Scale-Set")
#   admin_usename        = each.value["admin_usename"]
#   admin_password       = lookup(each.value, "admin_password", null)

#   #autoscale
#   autoscale_name     = each.value["autoscale_name"]
#   min_capacity       = lookup(each.value, "min_capacity", 1)
#   max_capacity       = lookup(each.value, "max_capacity", 10)
#   metric_name        = each.value["metric_name"]
#   scaleout_threshold = lookup(each.value, "scaleout_threshold", 80)
#   scalein_threshold  = lookup(each.value, "scalein_threshold", 20)

#   tags = var.tags

# }
