locals {}

resource "azurerm_resource_group" "rg" {
  name     = var.azurerm_rg_name
  location = var.azurerm_rg_location
}

resource "azurerm_availability_set" "as" {
  name                = var.azurerm_as_name
  location            = azurerm_resource_group.ag.location
  resource_group_name = azurerm_resource_group.ag.name
}

resource "azurerm_virtual_network" "vnet" {
  name                = join(" ", [azure_resource_group.rg.name, "-1"])
  address_space       = var.azurerm_vn_address_space
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}
