output "public_ip"  { 
	value = module.server_01.public_ip 
}

output "ssh_command" { 
	value = module.server_01.ssh_command 
}

output "vm_id" { 
	value = module.server_01.vm_id 
}