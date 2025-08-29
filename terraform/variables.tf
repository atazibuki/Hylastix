variable "location" { 
	type = string
	default = "West Europe" 						#minimum latency for Serbia
}

variable "resource_group_name" { 
	type = string
	default = "keycloak-rg" 
}

variable "prefix" {
	type = string
	default = "keycloak" 
}

variable "vnet_cidr" { 								#range 10.0.0.0/8. /16 range because of possible future expansion (Bastion/VPN/Firewall)
	type = string 
	default = "10.123.0.0/16" 
}

variable "subnet_cidr" { 
	type = string
	default = "10.123.10.0/24" 						#in VNet cidr/range
}

variable "vm_size" { 
	type = string 
	default = "Standard_B2s" 						#2vCPU, 4GB RAM; ok for start/good balance dev/test
}
variable "admin_username"{ 
	type = string
	default = "azureuser" 
}

variable "ssh_public_key" { 
	type = string
	default = "~/.ssh/id_rsa.pub" 
}

variable "ssh_public_key_value" {
  type    = string
  default = null
}

variable "ssh_allowed_cidrs" {
	description = "CIDR lists with 22/tcp (SSH)"
	type    = list(string)
	default = ["0.0.0.0/0"] 						# e.g ["203.0.113.10/32"] for this IP
}

variable "open_8080" { 
	type = bool
	default = true  
}

variable "os_disk_type" {
	type = string 
	default = "Standard_LRS" 						#cheap; options: StandardSSD_LRS/Premium_LRS
}

variable "tags" {
  type    = map(string)
  default = { 	
	project    = "Hylastix-keycloak"
	env        = "Dev"
	managed_by = "Terraform" 
  }
}