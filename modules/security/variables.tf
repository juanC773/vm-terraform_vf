variable "resource_group_name" {
  description = "Nombre del grupo de recursos"
  type        = string
}

variable "location" {
  description = "Ubicación de Azure"
  type        = string
}

variable "nsg_name" {
  description = "Nombre del Network Security Group"
  type        = string
}

variable "allowed_ports" {
  description = "Lista de puertos permitidos"
  type        = list(object({
    name     = string
    port     = string
    protocol = string
    priority = number
  }))
}