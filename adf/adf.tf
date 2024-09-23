resource "azurerm_data_factory" "adf" {
  name                = var.adf_name
  location            = var.location
  resource_group_name = var.resource_group_name

  vsts_configuration {
    account_name     = var.account_name
    branch_name      = var.branch_name
    project_name     = var.project_name
    repository_name  = var.repository_name
    root_folder      = var.root_folder
    tenant_id        = var.tenant_id
  }
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
  path                = "scdesafio90dias003"
}

resource "azurerm_data_factory_dataset_azure_blob" "list_files_especific" {
  name                = "ListEspecific"
  data_factory_id     = azurerm_data_factory.adf.id
  linked_service_name = azurerm_data_factory_linked_service_azure_blob_storage.storage_linked_service.name
  path                = "scdesafio90dias003"
  filename            = "@item().name"
}

resource "azurerm_data_factory_pipeline" "get_last_file" {
  name            = "get_last_file"
  data_factory_id = azurerm_data_factory.adf.id
  depends_on      = [
    azurerm_data_factory_dataset_azure_blob.list_files,
    azurerm_data_factory_dataset_azure_blob.list_files_especific
  ]
  variables = {
    latestModifiedDate = "String"
    latestFileName     = "String"
  }

  activities_json = <<JSON
  [
    {
      "name": "GetFileList",
      "type": "GetMetadata",
      "dependsOn": [],
      "policy": {
        "timeout": "0.12:00:00",
        "retry": 0,
        "retryIntervalInSeconds": 30,
        "secureOutput": false,
        "secureInput": false
      },
      "userProperties": [],
      "typeProperties": {
        "dataset": {
          "referenceName": "ListFiles",
          "type": "DatasetReference"
        },
        "fieldList": [
          "childItems"
        ],
        "storeSettings": {
          "type": "AzureBlobStorageReadSettings",
          "enablePartitionDiscovery": false
        },
        "formatSettings": {
          "type": "BinaryReadSettings"
        }
      }
    },
    {
      "name": "ForEachFile",
      "type": "ForEach",
      "dependsOn": [
        {
          "activity": "GetFileList",
          "dependencyConditions": [
            "Succeeded"
          ]
        }
      ],
      "userProperties": [],
      "typeProperties": {
        "items": {
          "value": "@activity('GetFileList').output.childItems",
          "type": "Expression"
        },
        "isSequential": true,
        "activities": [
          {
            "name": "GetFileMetadata",
            "type": "GetMetadata",
            "dependsOn": [],
            "policy": {
              "timeout": "0.12:00:00",
              "retry": 0,
              "retryIntervalInSeconds": 30,
              "secureOutput": false,
              "secureInput": false
            },
            "userProperties": [],
            "typeProperties": {
              "dataset": {
                "referenceName": "ListEspecific",
                "type": "DatasetReference"
              },
              "fieldList": [
                "lastModified"
              ],
              "storeSettings": {
                "type": "AzureBlobStorageReadSettings",
                "enablePartitionDiscovery": false
              },
              "formatSettings": {
                "type": "BinaryReadSettings"
              }
            }
          },
          {
            "name": "IfNewer",
            "type": "IfCondition",
            "dependsOn": [
              {
                "activity": "GetFileMetadata",
                "dependencyConditions": [
                  "Succeeded"
                ]
              }
            ],
            "userProperties": [],
            "typeProperties": {
              "expression": {
                "value": "@greater(activity('GetFileMetadata').output.lastModified, variables('latestModifiedDate'))",
                "type": "Expression"
              },
              "ifTrueActivities": [
                {
                  "name": "SetLatestModifiedDate",
                  "type": "SetVariable",
                  "dependsOn": [],
                  "policy": {
                    "secureOutput": false,
                    "secureInput": false
                  },
                  "userProperties": [],
                  "typeProperties": {
                    "variableName": "latestModifiedDate",
                    "value": "@activity('GetFileMetadata').output.lastModified"
                  }
                },
                {
                  "name": "SetLatestFileName",
                  "type": "SetVariable",
                  "dependsOn": [],
                  "policy": {
                    "secureOutput": false,
                    "secureInput": false
                  },
                  "userProperties": [],
                  "typeProperties": {
                    "variableName": "latestFileName",
                    "value": "@item().name"
                  }
                }
              ]
            }
          }
        ]
      }
    }
  ]
  JSON
}

resource "azurerm_data_factory_trigger_schedule" "repeat_trigger" {
  name            = "repeat-trigger"
  data_factory_id = azurerm_data_factory.adf.id
  pipeline_name   = azurerm_data_factory_pipeline.get_last_file.name
  interval        = 1
  frequency       = "Day"
}

resource "azurerm_data_factory_integration_runtime_self_hosted" "shir" {
  name                = "adf-poc-shir"
  data_factory_id     = azurerm_data_factory.adf.id
}