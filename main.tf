resource "azurerm_resource_group" "rgvm" {
  name     = "prahlad"
  location = " canadaeast "
}

resource "azurerm_virtual_network" "vnet01" {
  name                = "vnetvm"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rgvm.location
  resource_group_name = azurerm_resource_group.rgvm.name
}

resource "azurerm_subnet" "subnet02" {
  name                 = "subnetvm"
  resource_group_name  = azurerm_resource_group.rgvm.name
  virtual_network_name = azurerm_virtual_network.vnet01.name
  address_prefixes     = ["10.0.1.0/24"]

}
resource "azurerm_public_ip" "publicivm" {
  name                = "ipvm"
  resource_group_name = azurerm_resource_group.rgvm.name
  location            = azurerm_resource_group.rgvm.location
  allocation_method   = "Static"
  sku = "Basic"
  
}
resource "azurerm_network_interface" "nicvm" {
  name                = "nicvm01"
  location            = azurerm_resource_group.rgvm.location
  resource_group_name = azurerm_resource_group.rgvm.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet02.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.publicivm.id
  }
}
resource "azurerm_linux_virtual_machine" "newvm" {
  name                = "vm11"
  resource_group_name = azurerm_resource_group.rgvm.name
  location            = azurerm_resource_group.rgvm.location
  size                = "Standard_F2"
  disable_password_authentication = false
  admin_username      = "adminuser"
  admin_password = "admin@123456"
  network_interface_ids = [
    azurerm_network_interface.nicvm.id,
  ]


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