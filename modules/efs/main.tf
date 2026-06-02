resource "aws_efs_file_system" "wordpress_efs" {
  creation_token = "wordpress-efs"

  tags = {
    Name = "Wordpress-EFS"
  }
}
##EFS MOUNT TARGETS
resource "aws_efs_mount_target" "efs_mount" {
  count = length(var.private_subnet_ids)

  file_system_id  = aws_efs_file_system.wordpress_efs.id
  subnet_id       = var.private_subnet_ids[count.index]
  security_groups = [var.efs_security_group_id]
}

resource "aws_efs_access_point" "wordpress_ap" {
  file_system_id = aws_efs_file_system.wordpress_efs.id
  posix_user {
    uid = 33
    gid = 33
  }
  root_directory {
    path = "/wordpress"
    creation_info {
      owner_gid   = 33
      owner_uid   = 33
      permissions = "755"
    }
  }
  tags = {
    Name = "wordpress-access-point"
  }
}