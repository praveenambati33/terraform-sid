module "ASP-SHARED-ResourceGroup" {

  source            = "../../modules/ResourceGroup"
  resourcegroupname = var.asp-resourcegroupname
  location          = var.location
  tags              = var.tags

}

module "ApplicationServicePlan" {

  depends_on = [
    module.ASP-SHARED-ResourceGroup
  ]
  source            = "../../modules/ApplicationServicePlan"
  resourcegroupname = module.ASP-SHARED-ResourceGroup.rg_name_out
  serviceplanname   = var.serviceplanname
  location          = var.location
  ostype            = var.ostype
  sku               = var.sku
  tags              = var.tags
  
}