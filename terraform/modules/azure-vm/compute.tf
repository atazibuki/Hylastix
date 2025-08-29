# Linux VM (Ubuntu 24.04 LTS Gen2), OS disk = 64GB
locals {
  ssh_pub = var.ssh_public_key_value != null ? var.ssh_public_key_value : file(var.ssh_public_key)
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = local.vm
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  network_interface_ids = [azurerm_network_interface.nic.id]

  admin_username = var.admin_username
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_username
    public_key = local.ssh_pub
  }

  os_disk {
    name                 = "${var.prefix}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = var.os_disk_type
    disk_size_gb         = 64
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  tags = var.tags
}

locals {
    vm     = "${var.prefix}-vm"
}