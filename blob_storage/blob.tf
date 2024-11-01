resource "azurerm_storage_account" "storage_account" {
  name                     = var.sa_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  min_tls_version          = "TLS1_2"
   blob_properties {
    cors_rule {
      allowed_headers    = ["*"]
      allowed_methods    = ["DELETE", "GET", "HEAD", "MERGE", "POST", "OPTIONS", "PUT", "PATCH"]
      allowed_origins    = ["*"]
      exposed_headers    = ["*"]
      max_age_in_seconds = 200
    }
  }
  
}

# Debug Status=404 Code="ResourceNotFound ao criar o Storage Container
resource "random_string" "id" {
  length  = 4
  upper   = false
  special = false
}

resource "azurerm_storage_container" "storage_container" {
  name                  = var.sc_name
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"

}

resource "azurerm_storage_blob" "script_blob" {
  name                   = "adf-shir.ps1"
  storage_account_name   = azurerm_storage_account.storage_account.name
  storage_container_name = azurerm_storage_container.storage_container.name
  type                   = "Block"
  access_tier            = "Cool"
  source                 = "./files/gatewayinstall.ps1"
}


resource "azurerm_storage_blob" "matricula_blob" {
  name                   = "matricula.csv"
  storage_account_name   = azurerm_storage_account.storage_account.name
  storage_container_name = azurerm_storage_container.storage_container.name
  type                   = "Block"
  source                 = "./files/matricula.csv"
}

/*
resource "azurerm_storage_account_network_rules" "deny_rule" {
  storage_account_id = azurerm_storage_account.storage_account.id
  
  default_action             = "Deny"
  ip_rules                   = []
  virtual_network_subnet_ids = []
  bypass                     = ["Metrics", "Logging", "AzureServices"]

  depends_on = [
    azurerm_storage_blob.script_blob
  ]
}
*/
