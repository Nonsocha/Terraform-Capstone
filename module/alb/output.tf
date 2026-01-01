output "alb_dns_name" {
  value = aws_alb.alb.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.wordpress_tg.arn
}

output "alb_sg_id" {
  value = var.alb_sg_id  # or aws_security_group if defined in this module
}
