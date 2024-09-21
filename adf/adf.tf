resource "azurerm_data_factory" "adf" {
  name                = var.adf_name
  location            = var.location
  resource_group_name = var.resource_group_name

  vsts_configuration {
    account_name = "desafio90dias3"
    branch_name = "main"
    project_name = "projeto-desafio"
    repository_name = "projeto-desafio"
    root_folder = "/"
    tenant_id = "641ee1ae-46c0-48ed-9e97-4e682f63db5f"
  }

}
resource "azurerm_data_factory_linked_service_azure_blob_storage" "storage_linked_service" {
  name                = "StorageLinkedService"
  data_factory_id     = azurerm_data_factory.adf.id
  connection_string   = var.primary_connection_string
}
/*
resource "azurerm_data_factory_pipeline" "matricula_pipeline" {
  name                = "matricula-pipeline"
  data_factory_id     = azurerm_data_factory.adf.id

  variables = {
    "matricula" = "123456"
  }

  activities_json = <<JSON
[
    {
        "name": "CreateBlob",
        "type": "Copy",
        "dependsOn": [],
        "typeProperties": {
            "source": {
                "type": "BlobSource"
            },
            "sink": {
                "type": "BlobSink",
                "linkedServiceName": {
                    "referenceName": "StorageLinkedService",
                    "type": "LinkedServiceReference"
                }
            }
        },
        "inputs": [],
        "outputs": []
    },
    {
        "name": "EditBlob",
        "type": "Copy",
        "dependsOn": [
            {
                "activity": "CreateBlob"
            }
        ],
        "typeProperties": {
            "source": {
                "type": "BlobSource"
            },
            "sink": {
                "type": "BlobSink",
                "linkedServiceName": {
                    "referenceName": "StorageLinkedService",
                    "type": "LinkedServiceReference"
                }
            }
        },
        "inputs": [],
        "outputs": []
    }
]
  JSON
  depends_on = [ azurerm_data_factory_linked_service_azure_blob_storage.storage_linked_service ]
}
  
resource "azurerm_data_factory_integration_runtime_self_hosted" "shir" {
  name                = "adf-poc-shir"
  data_factory_id     = azurerm_data_factory.adf.id
}

resource "azurerm_data_factory_trigger_schedule" "repeat_trigger" {
  name            = "repeat-trigger"
  data_factory_id = azurerm_data_factory.adf.id
  pipeline_name   = azurerm_data_factory_pipeline.pipeline.name
  interval  = 1
  frequency = "Day"
}
*/