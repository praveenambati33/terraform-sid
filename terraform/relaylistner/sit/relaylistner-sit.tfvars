#Resource Group
resourcegroupname     = "eus-perf-relaylistner-rg"
location              = "eastus"

# Storage Account for App Service and App logs
storageaccountname     = ["eusperfrelaylistnerr9989"]

applicationinsightsname = "eus-perf-relaylistner-fnapp-01"
containers_list =[]

# Function Application
functionappname = "eus-perf-relaylistner-fnapp-02"
stack_version   = { java = "~8" }

#Application Configuration
function_app_application_settings = {
  
  "" = ""

}

# Key vault to secure the application sensitive information
keyvaultname = "eus-perf-relaylistner-kv-02"

tags = {
  "Application Name" = "Fn-App Shared ASP"
  "applicationType"  = "serverless-relaylistner"
  "Dept Id"          = "411"
  "Environment"      = "Ent SIT2"
}