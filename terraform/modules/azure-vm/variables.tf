variable "prefix" {
	type = string 
}

variable "location" {
	type = string
}

variable "resource_group_name" {
	type = string
}

variable "vnet_cidr" { 
	type = string 												# e.g. 10.123.0.0/16
}
  
variable "subnet_cidr" { 
	type = string 												# e.g. 10.123.10.0/24
}   

variable "vm_size" { 
	type = string 												# e.g. Standard_B2s
}

variable "admin_username"{ 
	type = string 
}

variable "ssh_public_key" { 
	type = string 												# path - .pub key
}

# default for all, for prod should be restricted
variable "ssh_allowed_cidrs" {
	type    = list(string)
	default = ["*"]
}

# Open dev port 8080 (Keycloak dev)
variable "open_8080" {
	type    = bool
	default = true
}

variable "os_disk_type" {
	type    = string
	default = "Standard_LRS" 									# StandardSSD_LRS / Premium_LRS
}

variable "disk_size_gb" {
	type    = number
	default = null           									# if null, use default image size
}

# Image (Ubuntu 24.04 LTS Gen2 – noble)
	variable "image_publisher" { 
	type = string
	default = "Canonical" 
}

variable "image_offer" { 
	type = string 
	default = "ubuntu-24_04-lts" 
}

variable "image_sku" { 
	type = string
	default = "server" 
}

variable "image_version" { 
	type = string 
	default = "latest" 
}

variable "ssh_public_key_value" {
  type        = string
  default     = null
}

variable "auto_shutdown_enabled" {
  type        = bool
  default     = true
  description = "Daily shutdown of VMs"
}

variable "auto_shutdown_time" {
  type        = string
  default     = "1800"    									# HHmm 
  description = "Time for auto shutdown"
}

variable "auto_shutdown_timezone" {
  type        = string
  default     = "Central European Standard Time"  			# Europe/Belgrade
  description = "Timezone"
}

variable "auto_shutdown_notification_email" {
  type        = string
  default     = null      									# e.g. "you@example.com"
}

variable "auto_shutdown_notification_minutes_before" {
  type        = number
  default     = 30
  description = "Notification X min before shutdown"
}

variable "tags" {
  type    = map(string)
  default = {}
}