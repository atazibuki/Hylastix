# Network Security Group
resource "azurerm_network_security_group" "nsg" {
  name                = local.nsg
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

# Base rules + optional Keycloak 8080 + extra user-defined rules
locals {
  base_rules = {
    ssh = {
      priority     = 100
      port         = 22
      protocol     = "Tcp"
      source_cidrs = var.ssh_allowed_cidrs
      description  = "SSH"
    }
    http = {
      priority     = 110
      port         = 80
      protocol     = "Tcp"
      source_cidrs = ["0.0.0.0/0"]
      description  = "HTTP"
    }
    https = {
      priority     = 120
      port         = 443
      protocol     = "Tcp"
      source_cidrs = ["0.0.0.0/0"]
      description  = "HTTPS"
    }
  }

  kc_8080 = var.open_8080 ? {
    keycloak_8080 = {
      priority     = 130
      port         = 8080
      protocol     = "Tcp"
      source_cidrs = ["0.0.0.0/0"]
      description  = "Keycloak (dev)"
    }
  } : {}

  effective_rules = merge(local.base_rules, local.kc_8080)
}

# Creating Inbound rules
resource "azurerm_network_security_rule" "rules" {
  for_each = local.effective_rules

  name                        = each.key
  priority                    = each.value.priority
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = each.value.protocol
  source_port_range           = "*"
  destination_port_range      = tostring(each.value.port)
  source_address_prefixes     = each.value.source_cidrs
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.nsg.name
  resource_group_name         = var.resource_group_name
  description                 = try(each.value.description, null)
}

# NIC + NSG association
resource "azurerm_network_interface_security_group_association" "nic_nsg" {                  #associating NSG to NIC
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

locals {
    nsg    = "${var.prefix}-nsg"
}