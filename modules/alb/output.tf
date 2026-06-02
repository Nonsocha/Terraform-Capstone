output "alb_arn" {
  description = "The ARN of the Application Load Balancer"
  value       = aws_lb.wordpress_alb.arn
  
}

output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_lb.wordpress_alb.dns_name
  
}

output "target_group_arn" {
    description = "The ARN of the Target Group"
    value       = aws_lb_target_group.wordpress_tg.arn
}