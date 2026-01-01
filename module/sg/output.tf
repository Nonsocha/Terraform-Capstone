output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}

output "ssh_sg_id" {
  value = aws_security_group.ssh_sg.id
}

output "webserver_sg_id" {
  value = aws_security_group.webserver_sg.id
}

output "rds_sg_id" {
  value = aws_security_group.db_sg.id
}

output "bastion_sg_id" {
  value = aws_security_group.bastion_sg.id
}

output "efs_sg_id" {
  value = aws_security_group.efs_sg.id
}
