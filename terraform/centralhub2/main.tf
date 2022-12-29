#TEST

#Resource Group
module "CHub_ResourceGroup" {

  # source            = "../../modules/ResourceGroup"
  # source            = "https://Org-SAMS@dev.azure.com/Org-SAMS/Proj_IaaC_P32H-Az-tenant-hHPHC-Subs/_git/modules/ResourceGroup"
  # source            = "./ResourceGroup"
  source            = "git::https://dev.azure.com/Org-SAMS/Proj_IaaC_P32H-Az-tenant-hHPHC-Subs/_git/modules?path=/ResourceGroup/"
  resourcegroupname = var.resourcegroupname
  location          = var.location
  tags              = var.tags

}
