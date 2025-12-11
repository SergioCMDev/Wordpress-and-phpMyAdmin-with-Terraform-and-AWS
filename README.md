# WordPress & phpMyAdmin en AWS con Terraform

[![Terraform](https://img.shields.io/badge/Terraform-1.x-623CE4?logo=terraform&logoColor=white)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-EC2%20%7C%20RDS%20%7C%20VPC-FF9900?logo=amazon-aws&logoColor=white)](https://aws.amazon.com/)
[![WordPress](https://img.shields.io/badge/WordPress-Latest-21759B?logo=wordpress&logoColor=white)](https://wordpress.org/)
[![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?logo=mysql&logoColor=white)](https://www.mysql.com/)
[![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-CI%2FCD-2088FF?logo=github-actions&logoColor=white)](https://github.com/features/actions)

## Descripción

Proyecto completo de **Infraestructura como Código (IaC)** que despliega automáticamente un entorno WordPress y phpMyAdmin en AWS utilizando Terraform. Incluye VPC personalizada, instancias EC2, base de datos RDS MySQL, y pipeline CI/CD con GitHub Actions.


## Arquitectura

```
┌─────────────────────────────────────────────────────────────────┐
│                           AWS Cloud                              │
│                                                                   │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │                        VPC Custom                         │  │
│  │                   CIDR: 10.0.0.0/16                       │  │
│  │                                                            │  │
│  │  ┌───────────────┐                  ┌─────────────────┐  │  │
│  │  │  Public Subnet│                  │ Private Subnet  │  │  │
│  │  │               │                  │                 │  │  │
│  │  │  ┌─────────┐  │                  │  ┌───────────┐ │  │  │
│  │  │  │   EC2   │  │                  │  │    RDS    │ │  │  │
│  │  │  │WordPress│◄─┼──────────────────┼─►│   MySQL   │ │  │  │
│  │  │  │phpMyAdmin│ │  Security Groups │  │  Database │ │  │  │
│  │  │  └────┬────┘  │                  │  └───────────┘ │  │  │
│  │  │       │       │                  │                 │  │  │
│  │  └───────┼───────┘                  └─────────────────┘  │  │
│  │          │                                                 │  │
│  │  ┌───────▼────────┐                                       │  │
│  │  │ Internet GW    │                                       │  │
│  │  └────────────────┘                                       │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                   │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │              GitHub Actions (OIDC Auth)                   │  │
│  │                                                            │  │
│  │  [Trigger] ──► [Terraform Plan] ──► [Terraform Apply]   │  │
│  └──────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────┘
```

## Características Principales

### Infraestructura
- **VPC Personalizada**: Red privada aislada con subnets públicas y privadas
- **EC2 Optimizada**: Instancia con WordPress y phpMyAdmin preconfigurados
- **RDS MySQL**: Base de datos gestionada con backups automáticos
- **Alta Disponibilidad**: Multi-AZ deployment para RDS
- **Seguridad por Capas**: Security Groups específicos para cada componente

### Automatización
- **GitHub Actions**: Pipeline CI/CD completamente automatizado
- **OIDC Authentication**: Autenticación sin credenciales estáticas con AWS
- **Terraform State**: Estado remoto gestionado en S3
- **User Data Scripts**: Configuración automática de instancias

### Seguridad
- **Secrets Management**: Contraseñas gestionadas de forma segura
- **Network Isolation**: Base de datos en subnet privada
- **Security Groups**: Reglas de firewall granulares
- **IAM Roles**: Permisos de mínimo privilegio

## Stack Tecnológico

### Infrastructure & Cloud
- **Terraform** - Infraestructura como código
- **AWS EC2** - Servidor de aplicación
- **AWS RDS** - Base de datos MySQL gestionada
- **AWS VPC** - Networking personalizado
- **AWS S3** - Almacenamiento de estado de Terraform

### Applications
- **WordPress** - CMS y plataforma web
- **phpMyAdmin** - Gestión de base de datos
- **Apache/Nginx** - Servidor web
- **MySQL 8.0** - Sistema de base de datos

### CI/CD & Automation
- **GitHub Actions** - Pipeline automatizado
- **OIDC** - Autenticación federada
- **Bash Scripts** - Automatización de configuración

## Estructura del Proyecto

```
.
├── .github/
│   └── workflows/
│       ├── terraform-plan.yml       # Pipeline para plan de Terraform
│       └── terraform-apply.yml      # Pipeline para aplicar infraestructura
│
├── OIDC_Setup/
│   ├── main.tf                      # Configuración OIDC para GitHub
│   ├── variables.tf                 # Variables OIDC
│   └── outputs.tf                   # Outputs del rol IAM
│
├── Infraestructure/
│   ├── main.tf                      # Configuración principal
│   ├── provider.tf                  # Provider de AWS
│   ├── variables.tf                 # Variables del proyecto
│   ├── outputs.tf                   # Outputs de la infraestructura
│   │
│   ├── vpc.tf                       # VPC y networking
│   ├── subnets.tf                   # Subnets públicas y privadas
│   ├── internet_gateway.tf          # Internet Gateway
│   ├── route_tables.tf              # Tablas de enrutamiento
│   │
│   ├── security_groups.tf           # Security Groups
│   ├── ec2.tf                       # Instancia EC2 WordPress
│   ├── rds.tf                       # Base de datos RDS MySQL
│   │
│   └── user_data/
│       └── wordpress_setup.sh       # Script de instalación WordPress
│
└── .gitignore                       # Archivos ignorados por Git
```

## Pre-requisitos

### Herramientas Necesarias
- [Terraform](https://www.terraform.io/downloads) >= 1.0
- [AWS CLI](https://aws.amazon.com/cli/) configurado
- Cuenta de AWS con permisos de administrador
- Cuenta de GitHub (para CI/CD)

### Conocimientos Recomendados
- Conceptos básicos de AWS (VPC, EC2, RDS)
- Terraform fundamentals
- Administración de WordPress

## Instalación y Despliegue

### Opción 1: Despliegue Manual con Terraform

#### 1. Clonar el Repositorio
```bash
git clone https://github.com/SergioCMDev/Wordpress-and-phpMyAdmin-with-Terraform-and-AWS.git
cd Wordpress-and-phpMyAdmin-with-Terraform-and-AWS
```

#### 2. Configurar Credenciales de AWS
```bash
aws configure
# Ingresa tus credenciales:
# - AWS Access Key ID
# - AWS Secret Access Key
# - Region (ej: eu-west-1)
```

#### 3. Configurar Variables
Edita `Infraestructure/variables.tf` o crea un archivo `terraform.tfvars`:

```hcl
aws_region           = "eu-west-1"
project_name         = "wordpress-aws"
environment          = "production"

# EC2 Configuration
instance_type        = "t3.micro"
key_name             = "mi-clave-ssh"

# RDS Configuration
db_instance_class    = "db.t3.micro"
db_name              = "wordpress_db"
db_username          = "admin"
db_password          = "TuPasswordSegura123!"  # Cambiar por una segura

# Network Configuration
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidr   = "10.0.1.0/24"
private_subnet_cidr  = "10.0.2.0/24"
```

#### 4. Inicializar Terraform
```bash
cd Infraestructure
terraform init
```

#### 5. Planificar el Despliegue
```bash
terraform plan
```

Revisa cuidadosamente los recursos que se crearán.

#### 6. Aplicar la Infraestructura
```bash
terraform apply
```

Escribe `yes` para confirmar. El proceso toma aproximadamente 10-15 minutos.

#### 7. Obtener las URLs
```bash
terraform output wordpress_url
terraform output phpmyadmin_url
terraform output rds_endpoint
```

### Opción 2: Despliegue Automático con GitHub Actions

#### 1. Fork del Repositorio
Haz fork de este repositorio en tu cuenta de GitHub.

#### 2. Configurar OIDC en AWS
```bash
cd OIDC_Setup
terraform init
terraform apply
```

Esto creará el rol IAM necesario para GitHub Actions.

#### 3. Configurar Secrets en GitHub
Ve a tu repositorio → Settings → Secrets and variables → Actions

Añade los siguientes secrets:
- `AWS_ROLE_ARN`: ARN del rol creado en el paso anterior
- `DB_PASSWORD`: Contraseña para la base de datos MySQL

#### 4. Activar el Workflow
```bash
git add .
git commit -m "feat: configure infrastructure"
git push origin main
```

El pipeline se ejecutará automáticamente y desplegará la infraestructura.

## Acceso a las Aplicaciones

### WordPress
```
URL: http://<EC2_PUBLIC_IP>/wordpress
Usuario: admin (configurar en primer acceso)
```

### phpMyAdmin
```
URL: http://<EC2_PUBLIC_IP>/phpmyadmin
Usuario: <db_username>
Password: <db_password>
```

### Base de Datos
```
Endpoint: <rds_endpoint>:3306
Database: wordpress_db
Username: admin
```

## Configuración de Seguridad

### Security Groups Configurados

#### EC2 Security Group
```hcl
Ingress:
  - Port 80 (HTTP)    from 0.0.0.0/0
  - Port 443 (HTTPS)  from 0.0.0.0/0
  - Port 22 (SSH)     from YOUR_IP (recomendado)

Egress:
  - All traffic       to 0.0.0.0/0
```

#### RDS Security Group
```hcl
Ingress:
  - Port 3306 (MySQL) from EC2 Security Group only

Egress:
  - None (no necesario)
```

### Mejoras de Seguridad Recomendadas

Para producción, considera:

1. **SSL/TLS**: Configura certificado SSL con AWS Certificate Manager
2. **SSH**: Restringe acceso SSH a IPs específicas
3. **Secrets**: Usa AWS Secrets Manager para contraseñas
4. **WAF**: Implementa AWS WAF para protección adicional
5. **Backups**: Configura políticas de backup para RDS y EC2

## Costos Estimados

Costos mensuales aproximados en AWS (región eu-west-1):

| Servicio | Tipo | Costo Mensual |
|----------|------|---------------|
| EC2 t3.micro | WordPress/phpMyAdmin | ~$8.50 |
| RDS db.t3.micro | MySQL Database | ~$15.00 |
| EBS Storage | 20 GB gp3 | ~$2.00 |
| Data Transfer | 1 GB out | ~$0.09 |
| **Total Estimado** | | **~$25.59/mes** |

 **Tip**: Usa la calculadora de precios de AWS para estimaciones precisas según tu uso.

##  CI/CD Pipeline

### Workflow de GitHub Actions

```yaml
Trigger: Push a main
    ↓
1. Checkout código
    ↓
2. Configurar Terraform
    ↓
3. Autenticación OIDC con AWS
    ↓
4. Terraform Init
    ↓
5. Terraform Plan
    ↓
6. Terraform Apply (si plan OK)
    ↓
7. Output de URLs y endpoints
```

### Variables de Entorno Requeridas

```yaml
AWS_REGION: eu-west-1
AWS_ROLE_ARN: arn:aws:iam::ACCOUNT:role/GitHubActionsRole
TF_VAR_db_password: ${{ secrets.DB_PASSWORD }}
```

## Testing y Validación

### Tests de Conectividad
```bash
# Test HTTP
curl -I http://<EC2_PUBLIC_IP>/wordpress

# Test MySQL
mysql -h <RDS_ENDPOINT> -u admin -p

# Test SSH
ssh -i mi-clave.pem ec2-user@<EC2_PUBLIC_IP>
```

### Logs y Debugging
```bash
# Logs de EC2
ssh ec2-user@<EC2_PUBLIC_IP>
sudo tail -f /var/log/httpd/error_log

# Logs de RDS
# Ver en AWS Console → RDS → Logs
```

## Escalabilidad

### Horizontal Scaling
Para escalar horizontalmente:
1. Implementa Application Load Balancer
2. Crea Auto Scaling Group para EC2
3. Configura almacenamiento compartido (EFS o S3)

### Vertical Scaling
Para escalar verticalmente:
```hcl
# En variables.tf
instance_type = "t3.small"  # o t3.medium, t3.large
db_instance_class = "db.t3.small"  # o db.t3.medium
```

##  Limpieza de Recursos

### Destruir Infraestructura con Terraform
```bash
cd Infraestructure
terraform destroy
```

 **Advertencia**: Esto eliminará:
- Instancia EC2 y todos los datos no persistidos
- Base de datos RDS (se creará snapshot final)
- VPC y todos los recursos de red
- Security Groups

### Destruir OIDC Setup
```bash
cd ../OIDC_Setup
terraform destroy
```

##  Troubleshooting

### Problema: WordPress no conecta a RDS
**Solución**: Verifica el security group de RDS permite tráfico desde EC2.

```bash
# Verificar security groups
aws ec2 describe-security-groups --group-ids sg-xxxxx
```

### Problema: No puedo acceder a phpMyAdmin
**Solución**: Verifica que Apache está corriendo y el virtual host está configurado.

```bash
ssh ec2-user@<EC2_IP>
sudo systemctl status httpd
sudo cat /etc/httpd/conf.d/phpmyadmin.conf
```

### Problema: Terraform apply falla
**Solución**: Verifica credenciales y permisos de IAM.

```bash
aws sts get-caller-identity
terraform plan -out=tfplan
```

##  Recursos Adicionales

- [Documentación de Terraform](https://www.terraform.io/docs)
- [AWS VPC Best Practices](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-security-best-practices.html)
- [WordPress Hardening](https://wordpress.org/support/article/hardening-wordpress/)
- [RDS MySQL Guide](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html)

##  Casos de Uso

Este proyecto es ideal para:

-  **Aprendizaje**: Entender IaC y arquitectura cloud
-  **Proyectos Personales**: Blog o sitio web personal
-  **Portfolio**: Demostrar habilidades DevOps
-  **Testing**: Ambiente de desarrollo rápido
-  **MVP**: Prototipos de aplicaciones web

## Roadmap de Mejoras

- [ ] Implementar HTTPS con certificado SSL/TLS
- [ ] Añadir CloudFront CDN para mejor rendimiento
- [ ] Configurar Auto Scaling con ALB
- [ ] Implementar CloudWatch monitoring y alertas
- [ ] Añadir backup automático a S3
- [ ] Implementar ElastiCache para caché de WordPress
- [ ] Multi-región deployment para DR
- [ ] Implementar terraform-docs para documentación

##  Contribuciones

¡Las contribuciones son bienvenidas! Si deseas mejorar este proyecto:

1. Fork el repositorio
2. Crea una rama feature (`git checkout -b feature/mejora`)
3. Commit tus cambios (`git commit -m 'feat: añadir mejora'`)
4. Push a la rama (`git push origin feature/mejora`)
5. Abre un Pull Request

## Licencia

Este proyecto está bajo la Licencia MIT. Ver archivo `LICENSE` para más detalles.

##  Autor

**Sergio Cristauro Manzano**

- GitHub: [@SergioCMDev](https://github.com/SergioCMDev)
- LinkedIn: [Sergio Cristauro](https://www.linkedin.com/in/sergio-cristauro/)
- Email: sergiocmdev@gmail.com

## Agradecimientos

- Comunidad de Terraform y AWS
- Documentación oficial de WordPress
- GitHub Actions documentation
- Stack Overflow community

---

**Si este proyecto te ha sido útil, considera darle una estrella en GitHub**

**¿Preguntas o sugerencias?** Abre un issue o contáctame directamente

**Proyectos Relacionados**: [Infra-AWS-EKS-Python](https://github.com/SergioCMDev/Infra-AWS-EKS-Python)
