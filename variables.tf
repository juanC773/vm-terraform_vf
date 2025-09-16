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

variable "location" {
  description = "Ubicación de Azure donde crear los recursos"
  type        = string
  default     = "East US"
}

variable "vm_size" {
  description = "Tamaño de la máquina virtual"
  type        = string
  default     = "Standard_B1s"
}