output "vm_id" {
  description = "ID de la máquina virtual"
  value       = azurerm_windows_virtual_machine.main.id
}

output "vm_name" {
  description = "Nombre de la máquina virtual"
  value       = azurerm_windows_virtual_machine.main.name
}

output "public_ip_address" {
  description = "Dirección IP pública"
  value       = azurerm_public_ip.main.ip_address
}

output "private_ip_address" {
  description = "Dirección IP privada"
  value       = azurerm_network_interface.main.private_ip_address
}

output "network_interface_id" {
  description = "ID de la interfaz de red"
  value       = azurerm_network_interface.main.id
}