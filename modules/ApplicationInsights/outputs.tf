output "azurerm_application_insights_out" {
    value = azurerm_application_insights.app-ai.instrumentation_key
    sensitive = true  
}