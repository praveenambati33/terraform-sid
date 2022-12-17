#Resource Group
asp-resourcegroupname = "eus-perf-shared-asp-rg"
location              = "eastus"

#App Servicen Plan for mrf and relaylistner

serviceplanname = "eus-perf-shared-asp-01"
ostype          = "Windows"
sku             = "Y1"

tags = {
  "Application Name" = "Fn-App Shared ASP"
  "applicationType"  = "serverless-mrf"
  "Dept Id"          = "411"
  "Environment"      = "Ent SIT2"
}