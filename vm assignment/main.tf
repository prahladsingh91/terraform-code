resource "azurerm_resource_group" "assignrg5" {
  name     = "sahu"
  location = " JapanWest "
}

resource "azurerm_virtual_network" "assignvnet" {
 depends_on = [ azurerm_resource_group.assignrg5 ]
  name                = "krishna"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.assignrg5.location
  resource_group_name = azurerm_resource_group.assignrg5.name
}

resource "azurerm_subnet" "subnet021" {
  depends_on = [ azurerm_virtual_network.assignvnet ]
  name                 = "sudama"
  resource_group_name  = azurerm_resource_group.assignrg5.name
  virtual_network_name = azurerm_virtual_network.assignvnet.name
  address_prefixes     = ["10.0.1.0/24"]

}
resource "azurerm_public_ip" "protocol" {
  name                = "narayan"
  resource_group_name = azurerm_resource_group.assignrg5.name
  location            = azurerm_resource_group.assignrg5.location
  allocation_method   = "Static"
  sku = "Basic"
  
}
resource "azurerm_network_interface" "nic2" {
  name                = "shreeram"
  location            = azurerm_resource_group.assignrg5.location
  resource_group_name = azurerm_resource_group.assignrg5.name

  ip_configuration {
    name                          = "pip"
    subnet_id                     = azurerm_subnet.subnet021.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.protocol.id
  }
}
resource "azurerm_linux_virtual_machine" "softvm" {
  depends_on = [ azurerm_network_interface.nic2 ]
  name                = "siyaram"
  resource_group_name = azurerm_resource_group.assignrg5.name
  location            = azurerm_resource_group.assignrg5.location
  size                = "Standard_F2"
  disable_password_authentication = false
  admin_username      = "admin01"
  admin_password = "admin@123456"
  network_interface_ids = [azurerm_network_interface.nic2.id]


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}