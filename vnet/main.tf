resource "azurerm_resource_group" "rgvnet" {
  name     = "rg99"
  location = "West Europe"
}


resource "azurerm_virtual_network" "vnet01" {
  name                = "vnet02"
  location            = azurerm_resource_group.rgvnet.location
  resource_group_name = azurerm_resource_group.rgvnet.name
  address_space       = ["10.0.0.0/16"]

}
resource "azurerm_subnet" "snet01" {
  name                 = "snet02"
  resource_group_name  = azurerm_resource_group.rgvnet.name
  virtual_network_name = azurerm_virtual_network.vnet01.name
  address_prefixes     = ["10.0.1.0/24"]
}