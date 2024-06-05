resource "azurerm_resource_group" "publiciprg" {
  name     = "rg101"
  location = "south india"
}

resource "azurerm_public_ip" "publicip" {
  name                = "protocol"
  resource_group_name = azurerm_resource_group.publiciprg.name
  location            = azurerm_resource_group.publiciprg.location
  allocation_method   = "Static"
  sku = "Standard"
}
