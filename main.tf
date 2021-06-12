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

resource "azurerm_subnet" "sn" {
  name                 = join(" ", [azure_resource_group.rg.name, "-internal"])
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vent.name
  address_prefixes     = var.azurerm_sn_address_prefixes
}

resource "azurerm_network_interface" "inet" {
  name                = join(" ", [azure_resource_group.rg.name, "-internal-nic"])
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  ip_configuration {
    name                          = join(" ", [azure_resource_group.rg.name, "-internal"])
    subnet_id                     = azurerm_subnet.sn.subnet_id
    private_ip_address_allocation = var.azurerm_inet_address_allocation
  }
}
