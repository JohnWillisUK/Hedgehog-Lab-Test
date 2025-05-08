output "backend_url" {
  value = "https://${azurerm_linux_web_app.backend.default_hostname}"
}

output "frontend_name" {
  value = azurerm_static_web_app.frontend.name
}
