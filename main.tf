terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

module "network" {
  source               = "./network"
  location             = var.location
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  subnet_name          = var.subnet_name
  nic_name             = var.nic_name
  address_space        = var.address_space
  address_prefix       = var.address_prefix
  //address_prefix_pe    = var.address_prefix_pe
  environment          = var.environment
  depends_on           = [azurerm_resource_group.rg]
}
/*
module "vm" {
  source               = "./vm"
  network_interface_id = module.network.network_interface_id
  resource_group_name  = azurerm_resource_group.rg.name
  location             = azurerm_resource_group.rg.location
  vm_name              = var.vm_name
  vm_size              = var.vm_size
  vm_admin_user        = var.vm_admin_user
  vm_admin_password    = var.vm_admin_password
  vm_disk_size         = var.vm_disk_size
  vm_publisher         = var.vm_publisher
  vm_offer             = var.vm_offer
  vm_sku               = var.vm_sku
  vm_version           = var.vm_version

  storage_account_name               = module.blob.storage_account_name
  storage_container_name             = module.blob.storage_container_name
  script_blob_name                   = module.blob.script_blob_name
  storage_account_primary_access_key = module.blob.storage_account_primary_access_key
  self_hosted_auth_key_1             = module.adf.self_hosted_auth_key_1
  depends_on                         = [azurerm_resource_group.rg]
}
*/

module "adf" {
  source                    = "./adf"
  adf_name                  = var.adf_name
  resource_group_name       = var.resource_group_name
  location                  = var.location
  account_name              = var.account_name
  branch_name               = var.branch_name
  project_name              = var.project_name
  repository_name           = var.repository_name
  root_folder               = var.root_folder
  tenant_id                 = var.tenant_id
  storage_account_id        = module.blob.storage_account_id
  storage_account_name      = var.sa_name
  primary_connection_string = module.blob.primary_connection_string
  subnet_def_id             = module.network.subnet_def_id
  //subnet_pe_id              = module.network.subnet_pe_id
  vnet_name                 = module.network.vnet_name
  virtual_network_id        = module.network.virtual_network_id
  depends_on                = [azurerm_resource_group.rg]

}
/*
module "blob" {
  source              = "./blob_storage"
  sa_name             = var.sa_name
  sc_name             = var.sc_name
  resource_group_name = var.resource_group_name
  location            = var.location
  depends_on          = [azurerm_resource_group.rg]

}
*/
