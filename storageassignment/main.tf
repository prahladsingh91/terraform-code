resource "azurerm_resource_group" "resource09" {
  name     = "shyamrj"
  location = "West Europe"
}

resource "azurerm_storage_account" "stac01" {
  name                     = "str23"
  resource_group_name      = azurerm_resource_group.resource09.name
  location                 = azurerm_resource_group.resource09.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_container" "cont67" {
 depends_on = [ azurerm_storage_account.stac01 ]
  name                  = "ipl"
  storage_account_name  = azurerm_storage_account.stac01.name
  container_access_type = "private"
}