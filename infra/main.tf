provider "azurerm" {
  features {}
  subscription_id = "541210db-5680-4c6f-afda-f2c000fd1988"
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_postgresql_flexible_server" "db" {
  name                   = var.db_name
  location               = azurerm_resource_group.main.location
  resource_group_name    = azurerm_resource_group.main.name
  administrator_login    = var.db_admin
  administrator_password = var.db_password
  sku_name               = "B_Standard_B1ms"
  version                = "13"
  storage_mb             = 32768

  backup_retention_days        = 7
  geo_redundant_backup_enabled = false

  delegated_subnet_id = null
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_all" {
  name             = "AllowAll"
  server_id        = azurerm_postgresql_flexible_server.db.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "255.255.255.255"
}

resource "azurerm_service_plan" "backend_plan" {
  name                = "${var.app_name}-plan"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "backend" {
  name                = "${var.app_name}-backend"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  service_plan_id     = azurerm_service_plan.backend_plan.id

  site_config {
    always_on = true
  }

  app_settings = {
    WEBSITES_PORT            = "8000"
    POSTGRES_PASSWORD        = var.db_password
    DB_HOST                  = azurerm_postgresql_flexible_server.db.fqdn
    DB_NAME                  = "postgres"
    DB_USER                  = "${var.db_admin}@${azurerm_postgresql_flexible_server.db.name}"
    DOCKER_CUSTOM_IMAGE_NAME = "ghcr.io/johnwillisuk/hedgehog-lab-test-backend:latest"
  }
}

resource "azurerm_static_web_app" "frontend" {
  name                = "${var.app_name}-frontend"
  resource_group_name = azurerm_resource_group.main.name
  location            = "westeurope" # ✅ Changed from var.location to a valid region
  sku_tier            = "Free"
}
