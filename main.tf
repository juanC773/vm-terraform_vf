# Configuración del proveedor de Azure
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

# Configurar el proveedor de Azure
provider "azurerm" {
  features {}
}

# Crear un grupo de recursos
resource "azurerm_resource_group" "main" {
  name     = "rg-vm-terraform"
  location = "East US"
}

# Crear una red virtual
resource "azurerm_virtual_network" "main" {
  name                = "vnet-terraform"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

# Crear una subred
resource "azurerm_subnet" "internal" {
  name                 = "subnet-internal"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Crear IP pública
resource "azurerm_public_ip" "main" {
  name                = "pip-terraform-vm"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  allocation_method   = "Static"
  sku                = "Standard"
}

# Crear Network Security Group y regla para RDP/SSH
resource "azurerm_network_security_group" "main" {
  name                = "nsg-terraform-vm"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  # Regla para RDP (Windows) - Puerto 3389
  security_rule {
    name                       = "RDP"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Regla para SSH (Linux) - Puerto 22
  security_rule {
    name                       = "SSH"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Crear interfaz de red
resource "azurerm_network_interface" "main" {
  name                = "nic-terraform-vm"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main.id
  }
}

# Asociar Network Security Group a la interfaz de red
resource "azurerm_network_interface_security_group_association" "main" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = azurerm_network_security_group.main.id
}

# Crear máquina virtual Windows
resource "azurerm_windows_virtual_machine" "main" {
  name                = "vm-terraform"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password

  network_interface_ids = [
    azurerm_network_interface.main.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
}

# Outputs para obtener información de la VM
output "public_ip_address" {
  description = "Dirección IP pública de la máquina virtual"
  value       = azurerm_public_ip.main.ip_address
}

output "vm_name" {
  description = "Nombre de la máquina virtual"
  value       = azurerm_windows_virtual_machine.main.name
}

output "admin_username" {
  description = "Nombre de usuario administrador"
  value       = var.admin_username
}