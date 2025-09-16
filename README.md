# Máquina Virtual en Azure con Terraform

## Descripción del proyecto

Este proyecto implementa una máquina virtual Windows en Microsoft Azure utilizando Terraform para la gestión de infraestructura.

## Arquitectura implementada

La solución incluye los siguientes componentes:

- Grupo de recursos para organización
- Red virtual con subred interna
- IP pública estática
- Network Security Group con reglas de acceso
- Interfaz de red
- Máquina virtual Windows Server 2022

## Estructura de archivos

```
vm-terraform/
├── main.tf              # Recursos principales de Azure
├── variables.tf         # Definición de variables
├── terraform.tfvars     # Valores de configuración
└── .gitignore          # Archivos a ignorar en Git
```

## Especificaciones técnicas

- **Sistema operativo**: Windows Server 2022 Datacenter
- **Tamaño de VM**: Standard_B1s (1 vCPU, 1 GB RAM)
- **Almacenamiento**: Premium SSD
- **Conectividad**: RDP (puerto 3389) y SSH (puerto 22)
- **Región**: East US

## Configuración de variables

El archivo `terraform.tfvars` contiene:

```hcl
admin_username = "miusuario"
admin_password = "MiContraseña123!"
location = "East US"
vm_size = "Standard_B1s"
```

## Proceso de implementación

1. **Inicialización**: Se ejecutó `terraform init` para descargar los providers necesarios
2. **Planificación**: `terraform plan` para revisar los recursos a crear
3. **Aplicación**: `terraform apply` para crear la infraestructura en Azure
4. **Verificación**: Conexión exitosa via RDP a la IP pública asignada

## Resultados obtenidos

- VM funcional en Azure con acceso remoto
- Infraestructura completamente gestionada por código
- Costos minimizados usando el tier gratuito B1s
- Código versionado y reutilizable

## Comandos utilizados

```bash
terraform init
terraform plan
terraform apply

```

## Consideraciones de seguridad

- Las reglas de firewall permiten acceso desde cualquier IP
- Credenciales configuradas en variables
- Recomendado restringir acceso por IP en producción