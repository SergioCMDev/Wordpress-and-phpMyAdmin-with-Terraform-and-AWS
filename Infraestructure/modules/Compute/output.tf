output "instance_id" {
  description = "Instance ID"
  value       = aws_instance.ec2_instance.id
}

output "wordpress_dns" {
  description = "wordpress_url"
  value       = "http://${aws_instance.ec2_instance.public_dns}"
}

output "wordpress_public_dns" {
  description = "DNS público de la instancia EC2 con wordpress"
  value       = aws_instance.ec2_instance.public_dns
}

output "wordpress_url" {
  description = "Ip pública de la instancia EC2 con wordpress"
  value       = aws_instance.ec2_instance.public_ip
}
