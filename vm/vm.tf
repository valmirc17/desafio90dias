resource "azurerm_windows_virtual_machine" "vm" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.vm_admin_user
  admin_password      = var.vm_admin_password
  network_interface_ids = [
    var.network_interface_id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.vm_disk_size
  }

  source_image_reference {
    publisher = var.vm_publisher
    offer     = var.vm_offer
    sku       = var.vm_sku
    version   = var.vm_version
  }
}

#Extensão para execução do script de inicialização na VM Windows
resource "azurerm_virtual_machine_extension" "vmextension" {
  name                       = "ADF-SHIR"
  virtual_machine_id         = azurerm_windows_virtual_machine.vm.id
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.10"
  auto_upgrade_minor_version = true

  protected_settings = <<PROTECTED_SETTINGS
      {
          "fileUris": ["${format("https://%s.blob.core.windows.net/%s/%s", var.storage_account_name, var.storage_container_name, var.script_blob_name)}"],
          "commandToExecute": "${join(" ", ["powershell.exe -ExecutionPolicy Unrestricted -File",var.script_blob_name,"-gatewayKey ${var.self_hosted_auth_key_1}"])}",
          "storageAccountName": "${var.storage_account_name}",
          "storageAccountKey": "${var.storage_account_primary_access_key}"
      }
  PROTECTED_SETTINGS
}
