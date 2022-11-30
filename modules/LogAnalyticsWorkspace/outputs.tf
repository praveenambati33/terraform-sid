output "azurerm_log_analytics_workspace_output" {
    value = azurerm_log_analytics_workspace.law-ws.id
    sensitive = true  
}