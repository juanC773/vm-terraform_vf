# Implementación Modular de Máquina Virtual con Terraform

## Descripción del proyecto

Este proyecto representa la evolución de una implementación monolítica hacia una arquitectura modular para el despliegue de máquinas virtuales en Azure utilizando Terraform. La modularización sigue principios de separación de responsabilidades y reutilización de componentes.

## Arquitectura modular implementada

La solución se estructura en tres módulos principales:

### Módulo Networking
- **Responsabilidad**: Gestión de recursos de red
- **Componentes**: Red virtual (VNet) y subredes
- **Ubicación**: `modules/networking/`

### Módulo Security
- **Responsabilidad**: Configuración de seguridad y firewall
- **Componentes**: Network Security Groups y reglas de acceso
- **Ubicación**: `modules/security/`

### Módulo Compute
- **Responsabilidad**: Recursos computacionales
- **Componentes**: Máquina virtual, interfaz de red e IP pública
- **Ubicación**: `modules/compute/`

## Estructura del proyecto

```
vm-terraform/
├── main.tf                    # Orquestador principal
├── variables.tf               # Variables del proyecto
├── terraform.tfvars           # Configuración de valores
└── modules/
    ├── networking/
    │   ├── main.tf           # Recursos de red
    │   ├── variables.tf      # Variables del módulo
    │   └── outputs.tf        # Salidas del módulo
    ├── security/
    │   ├── main.tf           # Configuración de seguridad
    │   ├── variables.tf      # Variables de seguridad
    │   └── outputs.tf        # Outputs de NSG
    └── compute/
        ├── main.tf           # VM y recursos asociados
        ├── variables.tf      # Variables de compute
        └── outputs.tf        # Información de la VM
```

## Proceso de modularización

### 1. Análisis de componentes
Se identificaron las responsabilidades específicas del código monolítico:
- Red virtual y conectividad
- Reglas de seguridad y firewall
- Máquina virtual y almacenamiento

### 2. Separación en módulos
Cada conjunto de recursos se extrajo a módulos independientes con interfaces bien definidas através de variables y outputs.

### 3. Definición de interfaces
Se establecieron las dependencias entre módulos:
- Compute depende de Networking (subnet_id)
- Compute depende de Security (network_security_group_id)

### 4. Configuración dinámica
Se implementó configuración flexible através de variables complejas, como la lista de puertos permitidos en el módulo de seguridad.

## Ventajas de la implementación modular

### Reutilización
- Los módulos pueden utilizarse en diferentes proyectos
- Posibilidad de crear múltiples VMs usando el mismo módulo compute

### Mantenimiento
- Cambios aislados por responsabilidad
- Debugging más eficiente al localizar problemas

### Escalabilidad
- Fácil adición de nuevos componentes
- Posibilidad de versionar módulos independientemente

### Colaboración
- Diferentes equipos pueden trabajar en módulos específicos
- Separación clara de expertise técnico

## Configuración técnica

### Variables principales
```hcl
resource_group_name = "rg-vm-terraform-modular"
vm_name = "vm-terraform-modular"
vm_size = "Standard_B1s"
```

### Puertos configurados
- RDP (3389) para acceso remoto Windows
- SSH (22) para compatibilidad Linux
- HTTP (80) para servicios web

## Solución de problemas implementados

### Computer Name Length
Se resolvió el error de longitud del nombre de computadora agregando:
```hcl
computer_name = "vm-win"
```

### Dependencias entre módulos
Se utilizó `depends_on` para garantizar el orden correcto de creación de recursos.

## Resultados obtenidos

- VM funcional con IP pública: 172.190.10.14
- Arquitectura modular completamente operativa
- Código reutilizable y mantenible
- Demostración de evolución arquitectónica

## Comandos de despliegue

```bash
# Inicialización con módulos
terraform init

# Planificación con dependencias
terraform plan

# Aplicación modular
terraform apply
```

## Consideraciones futuras

La arquitectura modular facilita la implementación de:
- Múltiples entornos (desarrollo, staging, producción)
- Diferentes tipos de máquinas virtuales
- Integración con pipelines de CI/CD
- Versionado independiente de componentes