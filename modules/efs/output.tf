output "efs_file_system_id" {
  description = "EFS File System ID"

  value = aws_efs_file_system.wordpress_efs.id
}

output "efs_access_point_id" {
  description = "EFS Access Point ID"

  value = aws_efs_access_point.wordpress_ap.id
}

output "efs_dns_name" {
  description = "EFS DNS Name"

  value = aws_efs_file_system.wordpress_efs.dns_name
}