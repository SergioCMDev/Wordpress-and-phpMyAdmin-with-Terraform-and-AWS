output "bd_id" {
  description = "ID BD"
  value       = aws_db_instance.wordpress_db.id
}

output "db_address" {
  value = aws_db_instance.wordpress_db.endpoint
}
output "db_port" {
  description = "ID BD"
  value       = aws_db_instance.wordpress_db.port
}

output "db_endpoint" {
  value = aws_db_instance.wordpress_db.endpoint
}

output "db_password" {
  value = aws_db_instance.wordpress_db.password
}

output "db_username" {
  value = aws_db_instance.wordpress_db.username
}

output "db_name" {
  value = aws_db_instance.wordpress_db.db_name
}
