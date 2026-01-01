output "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.rds_db.endpoint

}

output "db_username" {
  description = "The username for the RDS database"
  value       = aws_db_instance.rds_db.username
  
}

output "db_password" {
  description = "The password for the RDS database"
  value       = aws_db_instance.rds_db.password
  
}

output "db_name" {
  description = "The name of the RDS database"
  value       = aws_db_instance.rds_db.db_name
  
}

