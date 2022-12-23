data "azurerm_subnet" "vm_subnet" {

  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.subnet_resource_group_name

}

resource "azurerm_linux_virtual_machine_scale_set" "linux_vmss" {

  name                = var.vmss_name
  resource_group_name = var.resourcegroupname
  location            = var.location
  sku                 = var.vmss_size
  instances           = var.vmss_instances

  overprovision          = false
  single_placement_group = false

  computer_name_prefix = var.computer_name_prefix
  admin_username       = var.admin_usename
  admin_password       = var.admin_password

  disable_password_authentication = false

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  os_disk {
    caching              = var.osdisk_caching
    storage_account_type = var.os_disk_type
    disk_size_gb         = var.os_disk_size_gb
  }

  network_interface {
    name    = var.vmss_nic_name
    primary = true

    ip_configuration {
      name      = var.ip_config_name
      primary   = true
      subnet_id = data.azurerm_subnet.vm_subnet.id
    }
  }

}


#Auto Scaling
resource "azurerm_monitor_autoscale_setting" "example" {

  depends_on          = [azurerm_linux_virtual_machine_scale_set.linux_vmss]
  name                = var.autoscale_name
  resource_group_name = var.resourcegroupname
  location            = var.location
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.linux_vmss.id

  profile {
    name = "defaultProfile"

    capacity {
      default = 1
      minimum = var.min_capacity
      maximum = var.max_capacity
    }

    rule {
      metric_trigger {
        metric_name        = var.metric_name
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.linux_vmss.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = var.scaleout_threshold
        metric_namespace   = "microsoft.compute/virtualmachinescalesets"
        dimensions {
          name     = "AppName"
          operator = "Equals"
          values   = ["App1"]
        }
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = var.metric_name
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.linux_vmss.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = var.scalein_threshold
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
  }

}
