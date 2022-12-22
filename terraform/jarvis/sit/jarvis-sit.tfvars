#Resource Group
resourcegroupname = "eus-perf-jarvis-virassnt-rg"
location          = "eastus"

# Storage Account for App Service and App logs
storage_list  = ["hphcperfvastorage"]
containers_list = []

applicationinsightsname = "HPHCPERFVAReporting"

#ServicePlan
serviceplanname    = "ASP-eusjarvisperfvirassntrg-a4f6"
ostype             = "Windows"
sku                = "Y1"

# Function Application
functionappname = "HPHCPERFVAReporting"
stack_version   = { dotnet = "3.1" }

#Application Configuration
function_app_application_settings = {

  "AzureWebJo6bsStorage" = "DefaultEndpointsProtocol=https;AccountName=hphcvastorage;AccountKey=cH599A/qwTxAxRtSWeSI49r3+s622q1i6mmQLVpfO2IHO8O6rRQ6fy8/a7mLiWV+7mKaSshVCanN10Mvi0riCA==;EndpointSuffix=core.windows.net"

}

# Key vault to secure the application sensitive information
keyvaultname = "HPHCVAPERFKeyVault"

hphcappservicename = "hphcva-perf"
hphc_serviceplanname = "HPHCVAperf"
hphc_applicationinsightsname ="HPHCVAperf3zbkz"
hphc_stack_version = { dotnet = "v4.0 "}

#Application Configuration
app_settings = {

  "AzureWebJo6bsStorage" = "DefaultEndpointsProtocol=https;AccountName=hphcvastorage;AccountKey=cH599A/qwTxAxRtSWeSI49r3+s622q1i6mmQLVpfO2IHO8O6rRQ6fy8/a7mLiWV+7mKaSshVCanN10Mvi0riCA==;EndpointSuffix=core.windows.net"

}


tags = {
  "Application Name" = "jarvis"
  "applicationType"  = "serverless-jarvis"
  "Dept Id"          = "411"
  "Environment"      = "Ent SIT2"
}
