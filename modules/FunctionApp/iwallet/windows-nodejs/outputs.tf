output "fn_ai_key_out" {
  value = azurerm_application_insights.iwallet-js-ai.instrumentation_key
  sensitive = true
}
