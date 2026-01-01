resource "aws_efs_file_system" "wordpress_efs" {
  creation_token = "wordpress-efs"
  encrypted      = true

  tags = {
    Name = "wordpress-efs"
  }
}
# Create EFS Mount Targets in each private subnet
resource "aws_efs_mount_target" "efs_mount" {
  count          = length(var.private_subnets)
  file_system_id = aws_efs_file_system.wordpress_efs.id
  subnet_id      = var.private_subnets[count.index]
  security_groups = [var.security_group_id] 
}
# Create an EFS Access Point for WordPress
resource "aws_efs_access_point" "wordpress_ap" {
  file_system_id = aws_efs_file_system.wordpress_efs.id

  posix_user {
    gid = 1000
    uid = 1000
    
  }

  root_directory {
    path = "/wordpress"
    creation_info {
      owner_gid   = 1000
      owner_uid   = 1000
      permissions = "0755"
    }
  }

  tags = {
    Name = "wordpress-ap"
  }
}
