# VNet & Subnet
resource "azurerm_virtual_network" "vnet" {                             #creating Virtual Network
  name                = local.vnet
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = [var.vnet_cidr]
  tags                = var.tags
}

resource "azurerm_subnet" "subnet" {
  name                 = local.subnet
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_cidr]
}

# Public IP
resource "azurerm_public_ip" "pip" {                                    #creating Public IP, to be available from Internet
  name                = local.pip
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"                                        #to be available after VM restart   
  sku                 = "Standard"
  tags                = var.tags
}

# NIC + NSG association
resource "azurerm_network_interface" "nic" {                            #creating NIC, to attach to VM, connect to VNet and have Public IP
  name                = local.nic                                 #creating network interface and allocating public IP to it from above created Public IP resource
  resource_group_name = var.resource_group_name
  location            = var.location

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }

  tags = var.tags
}

locals {
    vnet   = "${var.prefix}-vnet"
    subnet = "${var.prefix}-subnet"
    pip    = "${var.prefix}-pip"
    nic    = "${var.prefix}-nic"
}