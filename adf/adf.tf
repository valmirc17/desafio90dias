resource "azurerm_data_factory" "adf" {
  name                = var.adf_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_data_factory_pipeline" "pipeline" {
  name            = "pipelinedesafio90dias"
  data_factory_id = azurerm_data_factory.adf.id
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