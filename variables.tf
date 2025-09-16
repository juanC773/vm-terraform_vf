# Variables generales
variable "resource_group_name" {
  description = "Nombre del grupo de recursos"
  type        = string
  default     = "rg-vm-terraform"
}

variable "location" {
  description = "Ubicación de Azure donde crear los recursos"
  type        = string
  default     = "East US"
}

# Variables de networking
variable "vnet_name" {
  description = "Nombre de la red virtual"
  type        = string
  default     = "vnet-terraform"
}

variable "address_space" {
  description = "Espacio de direcciones de la VNet"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_name" {
  description = "Nombre de la subred"
  type        = string
  default     = "subnet-internal"
}

variable "subnet_address" {
  description = "Rango de direcciones de la subred"
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

# Variables de seguridad
variable "nsg_name" {
  description = "Nombre del Network Security Group"
  type        = string
  default     = "nsg-terraform-vm"
}

variable "allowed_ports" {
  description = "Puertos permitidos en el firewall"
  type        = list(object({
    name     = string
    port     = string
    protocol = string
    priority = number
  }))
  default = [
    {
      name     = "RDP"
      port     = "3389"
      protocol = "Tcp"
      priority = 1001
    },
    {
      name     = "SSH"
      port     = "22"
      protocol = "Tcp"
      priority = 1002
    }
  ]
}

# Variables de compute
variable "vm_name" {
  description = "Nombre de la máquina virtual"
  type        = string
  default     = "vm-terraform"
}

variable "vm_size" {
  description = "Tamaño de la máquina virtual"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Nombre del usuario administrador"
  type        = string
  default     = "adminuser"
}

variable "admin_password" {
  description = "Contraseña del usuario administrador"
  type        = string
  sensitive   = true
  
  validation {
    condition     = length(var.admin_password) >= 12
    error_message = "La contraseña debe tener al menos 12 caracteres."
  }
}