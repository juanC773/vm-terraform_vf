# Crear Network Security Group
resource "azurerm_network_security_group" "main" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = {
    Environment = "terraform"
    Module      = "security"
  }
}

# Crear reglas de seguridad dinámicamente
resource "azurerm_network_security_rule" "security_rules" {
  count = length(var.allowed_ports)

  name                        = var.allowed_ports[count.index].name
  priority                    = var.allowed_ports[count.index].priority
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = var.allowed_ports[count.index].protocol
  source_port_range           = "*"
  destination_port_range      = var.allowed_ports[count.index].port
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.main.name
}