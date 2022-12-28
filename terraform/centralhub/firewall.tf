# #Central Hub Central RG

# #Firewall
# data "azurerm_subnet" "vm_subnet" {

#   depends_on           = [module.CHub_subnet]
#   name                 = "AzureFirewallSubnet"
#   virtual_network_name = "eus-hub-central-vnet-01"
#   resource_group_name  = var.centralhub_resourcegroupname

# }

# data "azurerm_public_ip" "public_ip" {

#   depends_on          = [module.CHub_PublicIP]
#   name                = "eus-hub-central-fw01-pip"
#   resource_group_name = var.centralhub_resourcegroupname

# }

# resource "azurerm_firewall" "firewall" {

#   depends_on          = [module.CHub_subnet, module.CHub_PublicIP]
#   name                = var.firewall_name
#   resource_group_name = var.centralhub_resourcegroupname
#   location            = var.location
#   sku_name            = "AZFW_VNet"
#   sku_tier            = "Standard"

#   ip_configuration {
#     name                 = "IpConf"
#     subnet_id            = data.azurerm_subnet.vm_subnet.id
#     public_ip_address_id = data.azurerm_public_ip.public_ip.id
#   }

# }

# resource "azurerm_firewall_network_rule_collection" "network_rule" {

#   depends_on          = [azurerm_firewall.firewall]
#   name                = "eus-datycs-dev-rule"
#   azure_firewall_name = azurerm_firewall.firewall.name
#   resource_group_name = var.centralhub_resourcegroupname
#   priority            = 100
#   action              = "Allow"

#   rule {
#     name                  = "onprem-2-datycsdev"
#     source_addresses      = ["155.49.215.91"]
#     destination_ports     = ["443", "8080", "80"]
#     destination_addresses = ["172.29.6.32/27"]
#     protocols             = ["TCP", "UDP"]
#   }
#   rule {
#     name                  = "datycsdevvm-2-buildmachine"
#     source_addresses      = ["172.29.6.37"]
#     destination_ports     = ["22", "443"]
#     destination_addresses = ["34.69.152.242"]
#     protocols             = ["TCP", "UDP", "ICMP"]
#   }
#   rule {
#     name                  = "datycsdevvm-2-storage"
#     source_addresses      = ["172.29.6.37"]
#     destination_ports     = ["*"]
#     destination_addresses = ["Storage"]
#     protocols             = ["Any"]
#   }
#   rule {
#     name                  = "onprem-2-storage"
#     source_addresses      = ["155.49.215.91"]
#     destination_ports     = ["*"]
#     destination_addresses = ["Storage"]
#     protocols             = ["Any"]
#   }
# }


# resource "azurerm_firewall_application_rule_collection" "application_rule" {

#   depends_on          = [azurerm_firewall.firewall]
#   name                = "eus-simplify-rule"
#   azure_firewall_name = azurerm_firewall.firewall.name
#   resource_group_name = var.centralhub_resourcegroupname
#   priority            = 102
#   action              = "Allow"

#   rule {
#     name             = "SimplifyDev-To-Windows Update"
#     source_addresses = ["172.29.4.36", "172.29.4.52", "172.29.4.53"]
#     fqdn_tags        = ["WindowsUpdate"]
#   }
#   rule {
#     name             = "SimplifyDev-To-SpecificFQDN"
#     source_addresses = ["172.29.4.36", "172.29.4.52", "172.29.4.53"]
#     target_fqdns     = ["*"]
#     protocol {
#       port = "443"
#       type = "Https"
#     }
#     protocol {
#       port = "8080"
#       type = "Http"
#     }
#     protocol {
#       port = "80"
#       type = "Http"
#     }
#   }

# }
