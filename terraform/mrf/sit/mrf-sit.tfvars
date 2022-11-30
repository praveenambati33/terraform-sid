#Resource Group
resourcegroupname     = "eus-perf-mrf-rg"
asp-resourcegroupname = "eus-perf-shared-asp-rg"
location              = "eastus"

# Storage Account for App Service and App logs
storageaccountname     = "euspftransparencymrfp32"
storageaccountlogsname = "eusperfmrfrgb70b"

#App Servicen Plan for mrf and relaylistner

serviceplanname = "eus-prod-shared-asp-01"
ostype          = "Windows"
sku             = "Y1"

#Log Analytics workspace for AI 

lawworkspacename        = "eus-s-mrf-loganalyticsws-01"
applicationinsightsname = "eus-s-mrf-fnapp-02"


functionappname = "eus-perf-mrf-fnapp-02"
stack_version   = { node = "~14" }

function_app_application_settings = {
  "tracker_id"      = "AJKGDFJKHFDS"
  "backend_api_url" = "https://backend.domain.tld/api"
}


tags = {
  "Application Name" = "Fn-App Shared ASP"
  "applicationType"  = "serverless-mrf"
  "Dept Id"          = "411"
  "Environment"      = "Ent SIT2"
}
