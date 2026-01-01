output "efs_id" {
  value = aws_efs_file_system.wordpress_efs.id
}

output "efs_dns_name" {
  value = aws_efs_file_system.wordpress_efs.dns_name
}

output "efs_access_point_id" {
  value = aws_efs_access_point.wordpress_ap.id
}
