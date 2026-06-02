
resource "aws_launch_template" "wordpress_lt" {
  name_prefix   = "wordpress-launch-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_pair_name
  

  vpc_security_group_ids = var.security_group_ids

  user_data = base64encode(
    templatefile("${path.module}/userdata.sh", {
      efs_id       =  var.efs_id
      access_point =  var.access_point
      rds_endpoint  = var.rds_endpoint
      db_user       = var.db_user
      db_password   = var.db_password
      db_name       = var.db_name

    })
  )
 
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 10
      volume_type = "gp2"
      delete_on_termination = true
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "wordpress-instance"
  }
}

resource "aws_autoscaling_group" "wordpress_asg" {
  name                      = "wordpress-asg"
  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity
  vpc_zone_identifier       = var.private_subnet_ids
  health_check_type         = "EC2"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.wordpress_lt.id
    version = "$Latest"
  }

  target_group_arns = [var.target_group_arn]

  tag {
    key                 = "Name"
    value               = "wordpress-instance"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}