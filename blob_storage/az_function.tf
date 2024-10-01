resource "azurerm_storage_blob" "function_code" {
  name                   = "functionappcode.zip"
  storage_account_name   = azurerm_storage_account.storage_account.name
  storage_container_name = azurerm_storage_container.storage_container.name
  type                   = "Block"
  source                 = "my-function-app.zip"  # Caminho local do código ZIP
}

resource "azurerm_service_plan" "service_plan" {
  name                = "example"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_linux_function_app" "example" {
  name                = "teste-funcao-desafio90dias"
  resource_group_name = var.resource_group_name
  location            = var.location

  storage_account_name       = azurerm_storage_account.storage_account.name
  storage_account_access_key = azurerm_storage_account.storage_account.primary_access_key
  service_plan_id            = azurerm_service_plan.service_plan.id

  site_config {
    http2_enabled = true
  }

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME" = "python"
    "WEBSITE_RUN_FROM_PACKAGE" = "https://${azurerm_storage_account.storage_account.name}.blob.core.windows.net/${azurerm_storage_container.storage_container.name}/${azurerm_storage_blob.function_code.name}"
    "AZURE_STORAGE_CONNECTION_STRING"    = azurerm_storage_account.storage_account.primary_connection_string
    "AZURE_STORAGE_CONTAINER_NAME"       = azurerm_storage_container.storage_container.name
  }
}