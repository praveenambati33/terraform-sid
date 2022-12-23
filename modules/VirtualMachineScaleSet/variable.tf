variable "location" {
  type        = string
  description = "Resource loaction"
  default     = "eastus"
}

variable "tags" {
  description = "Additional resource tags"
  type        = map(string)
}

variable "resourcegroupname" {
  type        = string
  description = "Resource group name"
}

variable "subnet_resource_group_name" {
  description = "Subnet Resource group name"
}

variable "vmss_name" {
  description = "Virtual machine name"
}

variable "vmss_instances" {
  description = "Number of VMSS instances"
}

variable "virtual_network_name" {
  type        = string
  description = "Virtual network name"
}

variable "subnet_name" {
  description = "VM Subnet name"
}

variable "vmss_size" {
  description = "VM Size"

}

variable "admin_usename" {
  description = "VM admin user"
}

variable "admin_password" {
  description = "VM admin user password"
}

variable "computer_name_prefix" {
  description = "Computer name prefix where computer name starts with"
}

variable "image_publisher" {
  description = "VM image publisher"
}

variable "image_offer" {
  description = "VM image offer"
}

variable "image_sku" {
  description = "VM image SKU"
}

variable "image_version" {
  description = "VM image version e.g. 'latest' or perticaular image version number"
}

variable "osdisk_caching" {
  description = "VM OS disk caching"
}

variable "os_disk_type" {
  description = "VM OS disk type"
}

variable "os_disk_size_gb" {
  description = "VM OS disk size in GB"
}

variable "vmss_nic_name" {
  description = "VM NIC name"
}

variable "ip_config_name" {
  description = "VM IP configuration"
}

variable "autoscale_name" {
  description = "Autoscale name for VMSS"
}

variable "metric_name" {
  description = "Autoscale metrics name"
}

variable "scaleout_threshold" {
  description = "Scale out threshold value"
}

variable "scalein_threshold" {
  description = "Scale in threshold value"
}

variable "min_capacity" {
  description = "Minimum VMSS instance capacity for autoscale"
}

variable "max_capacity" {
  description = "Maximum VMSS instance capacity for autoscale"
}