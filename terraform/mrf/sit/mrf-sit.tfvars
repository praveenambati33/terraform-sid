#Resource Group
resourcegroupname = "eus-perf-mrf-rg"
location          = "eastus"

# Storage Account for App Service and App logs
storageaccountname  = ["euspftransparencymrfp32"]
fun_containers_list = []
# Storage Account for App logs
storageaccountlogsname = ["eusperfmrfrgb70b"]
logs_containers_list   = ["logs"]


# Log Analytics workspace for AI 
lawworkspacename        = "eus-s-mrf-loganalyticsws-01"
applicationinsightsname = "eus-s-mrf-fnapp-02"

# Function Application
functionappname = "eus-perf-mrf-fnapp-02"
stack_version   = { node = "~14" }

#Application Configuration
function_app_application_settings = {

  "AzureWebJobseusdevtransparencymrfp32_STORAGE" = "@Microsoft.KeyVault(SecretUri=https://eus-perf-mrf-kv-01.vault.azure.net/secrets/eus-s-transperancy-mrf-account-key/2d7757c37d3d4fc39b8a454a56ec7361)"
  "AzureWebJobsStorage"                          = "DefaultEndpointsProtocol=https;AccountName=eussmrfrgb70b;AccountKey=JzGnShEb7AdGZBPV2RDK6jOVGPnAkZy8i+lF1WsQhln4Hw5frjhr1Lj3jZZQO+jpDR8PwEY27J+j+ASt7QlUXw==;EndpointSuffix=core.windows.net"
  "MRF_CONTAINER_NAME"                           = "eussittransparencymrfp32"
  "TRANSPERANCY_MRF_BASE_URL"                    = "https://eussittransparencymrfp32.blob.core.windows.net/"
  "TRANSPERANCY_MRF_CONNECTION_STRING"           = "@Microsoft.KeyVault(SecretUri=https://eus-s-mrf-kv-01.vault.azure.net/secrets/eus-s-mrf-storage-sastoken/fcb07f1144da482682b5ded259801ade)"
  "WEB_CONTAINER_URL"                            = "https://eussittransparencymrfp32.z13.web.core.windows.net/"
  "WEBSITE_ENABLE_SYNC_UPDATE_SITE"              = "true"
  "WEBSITE_HEALTHCHECK_MAXPINGFAILURES"          = "10"

}

# Key vault to secure the application sensitive information
keyvaultname = "eus-perf-mrf-kv-01"

tags = {
  "Application Name" = "Fn-App Shared ASP"
  "applicationType"  = "serverless-mrf"
  "Dept Id"          = "411"
  "Environment"      = "Ent SIT2"
}
