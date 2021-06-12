locals {}

resource "azurerm_resource_group" "rg" {
  name     = var.azurerm_name
  location = var.azurerm_location
}
