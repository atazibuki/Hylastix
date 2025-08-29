resource "azurerm_resource_group" "rg" {
  name     = local.rg
  location = var.location
  tags     = var.tags
}

locals {
    rg     = "${var.prefix}-rg"
}