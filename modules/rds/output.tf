output "rds_endpoint" {
  value = aws_db_instance.wordpress.endpoint
}

output "db_port" {
  value = aws_db_instance.wordpress.port
}