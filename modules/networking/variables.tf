variable "resource_group_name" {
  description = "Nombre del grupo de recursos"
  type        = string
}

variable "location" {
  description = "Ubicación de Azure"
  type        = string
}

variable "vnet_name" {
  description = "Nombre de la red virtual"
  type        = string
}

variable "address_space" {
  description = "Espacio de direcciones de la VNet"
  type        = list(string)
}

variable "subnet_name" {
  description = "Nombre de la subred"
  type        = string
}

variable "subnet_address" {
  description = "Rango de direcciones de la subred"
  type        = list(string)
}