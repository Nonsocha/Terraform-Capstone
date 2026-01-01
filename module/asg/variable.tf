variable "ami_id" {}
variable "instance_type" {}
variable "key_pair_name" {}
variable "security_group_id" {
  type = list(string)
}
variable "max_size" {}
variable "min_size" {}
variable "desired_capacity" {}
variable "private_subnets" {
  type = list(string)
}
variable "target_group_arn" {}
variable "efs_id" {
  type        = string
  description = "The ID of the EFS file system"
}

variable "efs_ap_id" {
  type        = string
  description = "The ID of the EFS access point"
}

variable "rds_endpoint" {
  type        = string
  description = "The endpoint of the RDS instance"
  
}

variable "db_username" {
  type        = string
  description = "The username for the RDS database"
}

variable "db_password" {
  type        = string
  description = "The password for the RDS database"
}

variable "db_name" {
  type        = string
  description = "The name of the RDS database"
}
