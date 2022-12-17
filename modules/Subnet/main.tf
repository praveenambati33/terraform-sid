resource "azurerm_subnet" "subnet" {

  resource_group_name    = var.resource_group_name
  virtual_network_name   = var.virtual_network_name
  name                   = var.subnet_name
  address_prefixes       = var.subnet_address_prefixes

  service_endpoints                               = var.service_endpoints
  service_endpoint_policy_ids                     = var.service_endpoint_policy_ids
  private_endpoint_network_policies_enabled       = var.private_endpoint_network_policies_enabled
  private_link_service_network_policies_enabled   = var.private_link_service_network_policies_enabled

  dynamic "delegation" {
    for_each = var.delegation_settings
    content {
      name = delegation.value["subnet_delegation_name"]
      service_delegation {
      name = delegation.value["subnet_service_delegation_name"]
      }
    }
  }

}



