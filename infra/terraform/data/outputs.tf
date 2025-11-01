output "db_endpoint" {
  value       = aws_db_instance.mysql.address
  description = "RDS endpoint hostname"
}

output "db_name" {
  value       = aws_db_instance.mysql.db_name
  description = "Database name"
}

output "db_username" {
  value       = aws_db_instance.mysql.username
  description = "Database user"
}

output "db_password" {
  value       = aws_db_instance.mysql.password
  sensitive   = true
  description = "Database password (sensitive)"
}
