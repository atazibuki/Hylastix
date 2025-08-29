output "public_ip" { 
	value = azurerm_public_ip.pip.ip_address 
}

output "vm_id" { 
	value = azurerm_linux_virtual_machine.vm.id 
}

output "nic_id" { 
	value = azurerm_network_interface.nic.id 
}

output "subnet_id" { 
	value = azurerm_subnet.subnet.id 
}

output "vnet_id" { 
	value = azurerm_virtual_network.vnet.id 
}

output "ssh_command" { 
	value = "ssh ${var.admin_username}@${azurerm_public_ip.pip.ip_address}" 
}