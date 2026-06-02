output "asg_id" {
  description = "The name of the Auto Scaling Group"
  value       = aws_autoscaling_group.wordpress_asg.id

  
}

output "launch_configuration_id" {
  description = "The ID of the Launch Configuration"
  value       = aws_launch_template.wordpress_lt.id
}

