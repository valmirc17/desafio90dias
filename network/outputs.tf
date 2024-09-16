output "network_interface_id" {
 value = azurerm_network_interface.nic.id
}

output "subnet_def_id" {
    value = azurerm_subnet.subnet_default.id
  
}

/*output "subnet_pe_id" {
    value = azurerm_subnet.subnet_pe.id
  
}
*/
output "vnet_name" {
    value = azurerm_virtual_network.vnet.name
  
}

output "virtual_network_id" {
    value = azurerm_virtual_network.vnet.id
  
}
