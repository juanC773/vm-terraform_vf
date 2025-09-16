variable "resource_group_name" {
  description = "Nombre del grupo de recursos"
  type        = string
}

variable "location" {
  description = "Ubicación de Azure"
  type        = string
}

variable "vm_name" {
  description = "Nombre de la máquina virtual"
  type        = string
}

variable "vm_size" {
  description = "Tamaño de la máquina virtual"
  type        = string
}

variable "admin_username" {
  description = "Nombre del usuario administrador"
  type        = string
}

variable "admin_password" {
  description = "Contraseña del usuario administrador"
  type        = string
  sensitive   = true
}

variable "subnet_id" {
  description = "ID de la subred donde crear la VM"
  type        = string
}

variable "network_security_group_id" {
  description = "ID del Network Security Group"
  type        = string
}