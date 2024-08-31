resource "azurerm_virtual_network" "vnet" {
    name = var.virtual_network_name
    location = var.location
    resource_group_name = var.resource_group_name
    address_space = var.address_space
    
    tags = {
        environment = var.environment
    }
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.address_prefix

  depends_on = [azurerm_virtual_network.vnet]
}


resource "azurerm_network_interface" "nic" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}