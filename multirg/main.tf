resource "azurerm_resource_group" "singh" {
  name     = "terraformrg01"
  location = "West Europe"
}

resource "azurerm_resource_group" "singh1" {
  name     = "terraformrg02"
  location = "South India"
}

resource "azurerm_resource_group" "singh2" {
  name     = "terraformrg03"
  location = "australiacentral"
}

resource "azurerm_resource_group" "singh3" {
  name     = "terraformrg04"
  location = "JapanEast"
}