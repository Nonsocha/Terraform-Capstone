output "wordpress_sg_id" {
  value = aws_security_group.Wordpress_sg.id
}

output "rds_sg_id" {
  value = aws_security_group.rds_sg.id
}

output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}

output "bastion_sg_id" {
  value = aws_security_group.bastion_sg.id
}

output "efs_sg_id" {
  value = aws_security_group.efs_sg.id
}