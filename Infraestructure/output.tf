locals {
  output_format = <<-EOT
  
  ╔════════════════════════════════════════════════════════════╗
  ║           WORDPRESS DEPLOYMENT - INFORMACIÓN               ║
  ╚════════════════════════════════════════════════════════════╝
  
  🌐 ACCESO A WORDPRESS:
     URL Principal:  ${module.Compute.wordpress_url}
     Admin Panel:    ${module.Compute.wordpress_url}/wp-admin
     phpMyAdmin:     ${module.Compute.wordpress_url}/phpmyadmin
  
  🖥️  SERVIDOR EC2:
     Instance ID:    ${module.Compute.instance_id}
     IP Pública:     ${module.Compute.wordpress_dns}
     DNS:            ${module.Compute.wordpress_public_dns}
  
  🗄️  BASE DE DATOS:
     Endpoint:       ${module.DB.db_endpoint}
     Nombre:         ${module.DB.db_name}
     Puerto:         ${module.DB.db_port}
  
  🔐 SEGURIDAD:
     VPC ID:         ${module.Network.vpc_id}
  
  EOT
}
