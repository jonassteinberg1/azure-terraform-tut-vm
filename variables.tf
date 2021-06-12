variable "azurerm_rg_name" {
  type    = string
  default = "terraformTesting"
}

variable "azurerm_rg_location" {
  type    = string
  default = "eastus"
}

variable "azurerm_as_name" {
  type    = string
  default = "terraformTesting"
}

variable "azurerm_vn_address_space" {
  type    = list(any)
  default = ["10.0.0.0/16"]
}
