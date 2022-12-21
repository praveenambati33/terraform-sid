variable "location" {
    type = string
    description = "Resource loaction"
    default = "eastus"
}

variable "tags" {
  description = "Additional resource tags"
  type        = map(string)
}

variable "resourcegroupname" {
    type = string
    description = "Resource group name"
}

variable "virtualmachine_name" {
  description = "Virtual machine name"
}

variable "virtual_network_name" {
  type = string
  description = "Virtual network name"
}

variable "subnet_name" {
  description = "VM Subnet name"
}

variable "address_prefixes" {
  description = "VM Subnet address prefixes"  
}

variable "vm_nic_name" {
  description = "VM NIC name"
  
}

variable "ip_config_name" {
  description = "VM IP configuration"
  
}

variable "private_ip_address_allocation" {
  description = "Private IP address allocation"
  
}

variable "vm_size" {
  description = "VM Size"
  
}

variable "delete_os_disk_on_termination" {
  description = "Delete OS disks on termination option"
  
}

variable "delete_data_disks_on_termination" {
  description = "Delete data disks on termination option"
  
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

variable "osdisk_name" {
  description = "VM OS disk name"
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

variable "data_disks" {
  type = list
  default = []
  description = "VM data disks" 
}

variable "admin_usename" {
  description = "VM admin user"  
}

variable "admin_password" {
  description = "VM admin user password"  
}

variable "disable_password_authentication" {
  description = "VM disable password authentication option"
}


