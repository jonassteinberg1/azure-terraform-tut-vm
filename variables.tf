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
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "azurerm_sn_address_prefixes" {
  type    = list(string)
  default = ["10.0.2.0/24"]
}

variable "azurerm_inet_address_allocation" {
  type    = string
  default = "Dynamic"
}
