resource "azurerm_resource_group" "ramu1" {
  name     = "rgstorage"
  location = "West Europe"
}
resource "azurerm_storage_account" "example" {
  depends_on = [azurerm_resource_group.ramu1] 
  name                     = "prahladsinghr"
  resource_group_name      = "rgstorage"
  location                 = "West Europe"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}