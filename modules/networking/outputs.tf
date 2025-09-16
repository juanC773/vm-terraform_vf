output "vnet_id" {
  description = "ID de la red virtual"
  value       = azurerm_virtual_network.main.id
}

output "vnet_name" {
  description = "Nombre de la red virtual"
  value       = azurerm_virtual_network.main.name
}

output "subnet_id" {
  description = "ID de la subred"
  value       = azurerm_subnet.internal.id
}

output "subnet_name" {
  description = "Nombre de la subred"
  value       = azurerm_subnet.internal.name
}