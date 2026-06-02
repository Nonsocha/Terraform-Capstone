variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Private subnet IDs for RDS subnet group"
}

variable "wordpress_sg_id" {
  type        = string
  description = "WordPress security group ID"
}

variable "db_name" {
  type        = string
}

variable "db_password" {
  type        = string
  sensitive   = true
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "allocated_storage" {
  description = "Storage size for the RDS instance (in GB)"
  type        = number
}

variable "db_user" {
  type = string
}

variable "rds_security_group_ids" {
  type        = list(string)
  description = "List of security group IDs to attach to RDS instance"
  
}