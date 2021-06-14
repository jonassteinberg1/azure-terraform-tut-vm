locals {}

resource "azurerm_resource_group" "rg" {
  name     = var.azurerm_rg_name
  location = var.azurerm_rg_location
}

resource "azurerm_availability_set" "as" {
  name                = var.azurerm_as_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_virtual_network" "vnet" {
  name                = join("", [azurerm_resource_group.rg.name, "-1"])
  address_space       = var.azurerm_vn_address_space
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "sn" {
  name                 = join("", [azurerm_resource_group.rg.name, "-internal"])
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.azurerm_sn_address_prefixes
}

resource "azurerm_network_interface" "inet" {
  name                = join("", [azurerm_resource_group.rg.name, "-internal-nic"])
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  ip_configuration {
    name                          = join("", [azurerm_resource_group.rg.name, "-internal"])
    subnet_id                     = azurerm_subnet.sn.id
    private_ip_address_allocation = var.azurerm_inet_address_allocation
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = join("", [azurerm_resource_group.rg.name, "-vm-1"])
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_F2"
  admin_username      = "jonas"
  network_interface_ids = [
    azurerm_network_interface.inet.id,
  ]

  admin_ssh_key {
    username   = "jonas"
    public_key = file("~/.ssh/azure.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Debian"
    offer     = "debian-10"
    sku       = "10"
    version   = "latest"
  }
}
