output "storage_account_id" {
    value = azurerm_storage_account.storage_account.id
}

output "storage_account_name" {
    value = azurerm_storage_account.storage_account.name
}

output "storage_container_name" {
    value = azurerm_storage_container.storage_container.name
}

output "script_blob_name" {
    value = azurerm_storage_blob.script_blob.name
}

output "storage_account_primary_access_key" {
    value = azurerm_storage_account.storage_account.primary_access_key
  
}