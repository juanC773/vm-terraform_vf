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

# Crear grupo de recursos
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

# Módulo de networking
module "networking" {
  source = "./modules/networking"
  
  resource_group_name = azurerm_resource_group.main.name
  location           = azurerm_resource_group.main.location
  vnet_name          = var.vnet_name
  address_space      = var.address_space
  subnet_name        = var.subnet_name
  subnet_address     = var.subnet_address
}

# Módulo de seguridad
module "security" {
  source = "./modules/security"
  
  resource_group_name = azurerm_resource_group.main.name
  location           = azurerm_resource_group.main.location
  nsg_name           = var.nsg_name
  allowed_ports      = var.allowed_ports
}

# Módulo de compute
module "compute" {
  source = "./modules/compute"
  
  resource_group_name   = azurerm_resource_group.main.name
  location             = azurerm_resource_group.main.location
  vm_name              = var.vm_name
  vm_size              = var.vm_size
  admin_username       = var.admin_username
  admin_password       = var.admin_password
  subnet_id            = module.networking.subnet_id
  network_security_group_id = module.security.nsg_id
  
  depends_on = [module.networking, module.security]
}

# Outputs principales
output "vm_public_ip" {
  description = "IP pública de la máquina virtual"
  value       = module.compute.public_ip_address
}

output "vm_name" {
  description = "Nombre de la máquina virtual"
  value       = module.compute.vm_name
}

output "admin_username" {
  description = "Usuario administrador"
  value       = var.admin_username
}