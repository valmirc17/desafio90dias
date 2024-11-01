resource "azurerm_data_factory" "adf" {
  name                = var.adf_name
  location            = var.location
  resource_group_name = var.resource_group_name
/*
  vsts_configuration {
    account_name     = var.account_name
    branch_name      = var.branch_name
    project_name     = var.project_name
    repository_name  = var.repository_name
    root_folder      = var.root_folder
    tenant_id        = var.tenant_id
  }
*/
}

resource "azurerm_data_factory_linked_service_azure_blob_storage" "storage_linked_service" {
  name                = "StorageLinkedService"
  data_factory_id     = azurerm_data_factory.adf.id
  connection_string   = var.primary_connection_string
}

resource "azurerm_data_factory_dataset_azure_blob" "list_files" {
  name                = "ListFiles"
  data_factory_id     = azurerm_data_factory.adf.id
  linked_service_name = azurerm_data_factory_linked_service_azure_blob_storage.storage_linked_service.name
  path                = var.storage_container_name
}

resource "azurerm_data_factory_dataset_azure_blob" "list_files_especific" {
  name                = "ListEspecific"
  data_factory_id     = azurerm_data_factory.adf.id
  linked_service_name = azurerm_data_factory_linked_service_azure_blob_storage.storage_linked_service.name
  path                = var.storage_container_name
  filename            = "@item().name"
}

resource "azurerm_data_factory_dataset_delimited_text" "SaveCsvFile" {
  name                = "SaveCsvFile"
  data_factory_id     = azurerm_data_factory.adf.id
  linked_service_name = azurerm_data_factory_linked_service_azure_blob_storage.storage_linked_service.name

  azure_blob_storage_location {
    container               = var.storage_container_name
    filename            = "@concat('Matricula_', formatDateTime(utcnow(),'yyyyMMddHHmmss'), '.csv')"
  }

  column_delimiter    = ","
  row_delimiter       = "\n"
  encoding            = "UTF-8"
  quote_character     = ""
  escape_character    = "f"
  first_row_as_header = false
}

resource "azurerm_data_factory_dataset_delimited_text" "ListCsvFiles" {
  name                = "ListCsvFiles"
  data_factory_id     = azurerm_data_factory.adf.id
  linked_service_name = azurerm_data_factory_linked_service_azure_blob_storage.storage_linked_service.name

  azure_blob_storage_location {
    container               = var.storage_container_name
  }

  column_delimiter    = ","
  row_delimiter       = "\n"
  encoding            = "UTF-8"
  quote_character     = ""
  escape_character    = "f"
  first_row_as_header = false
}


resource "azurerm_data_factory_pipeline" "copy_file" {
  name            = "CopyFile"
  data_factory_id = azurerm_data_factory.adf.id
  depends_on      = [
    azurerm_data_factory_dataset_azure_blob.list_files,
    azurerm_data_factory_dataset_azure_blob.list_files_especific
  ]
  variables = {
    latestModifiedDate = ""
    latestFileName     = ""
    matricula = ""
  }

  activities_json = file("./files/pipeline.json")
}

resource "azurerm_data_factory_trigger_schedule" "repeat_trigger" {
  name            = "repeat-trigger"
  data_factory_id = azurerm_data_factory.adf.id
  pipeline_name   = azurerm_data_factory_pipeline.copy_file.name
  interval        = 1
  frequency       = "Day"
  start_time     = "2024-11-01T09:00:00Z"
}

resource "azurerm_data_factory_integration_runtime_self_hosted" "shir" {
  name                = "adf-poc-shir"
  data_factory_id     = azurerm_data_factory.adf.id
}
