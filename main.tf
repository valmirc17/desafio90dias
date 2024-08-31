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
    name = var.resource_group_name
    location = var.location
}

module "network" {
  source              = "./network"
  location = var.location
  resource_group_name = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  subnet_name = var.subnet_name
  nic_name = var.nic_name
  address_space = var.address_space
  address_prefix = var.address_prefix
  environment = var.environment
}

module "vm" {
  source = "./vm"
  network_interface_id = module.network.network_interface_id
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  vm_name = var.vm_name
  vm_size = var.vm_size
  vm_admin_user = var.vm_admin_user
  vm_admin_password = var.vm_admin_password
  vm_disk_size = var.vm_disk_size
  vm_publisher = var.vm_publisher
  vm_offer = var.vm_offer
  vm_sku = var.vm_sku
  vm_version = var.vm_version
}

module "adf" {
  source = "./adf"
  adf_name = var.adf_name
  resource_group_name = var.resource_group_name
  location = var.location
  
}

module "blob" {
  source = "./blob_storage"
  sa_name = var.sa_name
  sc_name = var.sc_name
  resource_group_name = var.resource_group_name
  location = var.location

}