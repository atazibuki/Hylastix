terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.114.0"
    }
  }
}

provider "azurerm" { 
  features {} 
}

################################# Virtual Machine #################################
module "server_01" {
  source              = "./modules/azure-vm"

  prefix              = var.prefix
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  vnet_cidr           = var.vnet_cidr
  subnet_cidr         = var.subnet_cidr

  vm_size             = var.vm_size
  admin_username      = var.admin_username
  ssh_public_key      = var.ssh_public_key
  ssh_public_key_value = var.ssh_public_key_value

  ssh_allowed_cidrs   = var.ssh_allowed_cidrs
  open_8080           = var.open_8080

  os_disk_type        = var.os_disk_type
  # disk_size_gb      = 64

  # Image: Ubuntu 24.04 LTS (Gen2)
  image_publisher = "Canonical"
  image_offer     = "ubuntu-24_04-lts"
  image_sku       = "server"
  image_version   = "latest" 

  tags = var.tags
}