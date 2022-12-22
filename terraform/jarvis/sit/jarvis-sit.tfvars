#Resource Group
resourcegroupname = "eus-perf-jarvis-virassnt-rg"
location          = "eastus"

# Storage Account for App Service and App logs
storageaccountname  = ["hphcperfvastorage"]
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

  "" = ""

}

# Key vault to secure the application sensitive information
keyvaultname = "HPHCVAPERFKeyVault"

tags = {
  "Application Name" = "jarvis"
  "applicationType"  = "serverless-jarvis"
  "Dept Id"          = "411"
  "Environment"      = "Ent SIT2"
}
