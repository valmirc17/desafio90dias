#--------Zonas privadas de DNS--------#

# DFS DNS Zone
resource "azurerm_private_dns_zone" "dfs_privatednszone" {
    name = "privatelink.dfs.core.windows.net"
    resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "dnszone-vnetlink-00" {
  name                  = "${var.vnet_name}-dnslink"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.dfs_privatednszone.name
  virtual_network_id    = var.virtual_network_id
  depends_on = [ azurerm_private_dns_zone.dfs_privatednszone ]
}

# Blob DNS Zone

resource "azurerm_private_dns_zone" "blob_privatednszone" {
    name = "privatelink.blob.core.windows.net"
    resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "dnszone-vnetlink-01" {
  name                  = "${var.vnet_name}-dnslink"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.blob_privatednszone.name
  virtual_network_id    = var.virtual_network_id
  depends_on = [azurerm_private_dns_zone.blob_privatednszone]
}

#--------Storage Account Private Endpoints and DNS A Records--------#
#DFS
resource "azurerm_private_endpoint" "pe_000" {
  name                = "${var.storage_account_name}-dfs"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_pe_id

  private_service_connection {
    name                           = "${var.storage_account_name}-connection"
    private_connection_resource_id = var.storage_account_id
    is_manual_connection           = false
    subresource_names              = ["dfs"]
  }

  private_dns_zone_group {
    name                 = azurerm_private_dns_zone.dfs_privatednszone.name
    private_dns_zone_ids = [azurerm_private_dns_zone.dfs_privatednszone.id]
  }
}

resource "azurerm_private_dns_a_record" "privatednsarecord-000" {
  name                = azurerm_private_endpoint.pe_000.name
  zone_name           = azurerm_private_dns_zone.dfs_privatednszone.name
  resource_group_name = var.resource_group_name
  ttl                 = "300"
  records             = [azurerm_private_endpoint.pe_000.private_service_connection.0.private_ip_address]
  depends_on          = [azurerm_private_endpoint.pe_000]
}

#Blob
resource "azurerm_private_endpoint" "pe_001" {
  name                = "${var.storage_account_name}-blob"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_pe_id

  private_service_connection {
    name                           = "${var.storage_account_name}-connection"
    private_connection_resource_id = var.storage_account_id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  private_dns_zone_group {
    name                 = azurerm_private_dns_zone.blob_privatednszone.name
    private_dns_zone_ids = [azurerm_private_dns_zone.blob_privatednszone.id]
  }
}

resource "azurerm_private_dns_a_record" "privatednsarecord-001" {
  name                = azurerm_private_endpoint.pe_001.name
  zone_name           = azurerm_private_dns_zone.blob_privatednszone.name
  resource_group_name = var.resource_group_name
  ttl                 = "300"
  records             = [azurerm_private_endpoint.pe_001.private_service_connection.0.private_ip_address]
  depends_on          = [azurerm_private_endpoint.pe_001]
}