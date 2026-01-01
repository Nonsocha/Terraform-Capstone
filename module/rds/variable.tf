variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
  
}
variable "db_name" {
  description = "Database name"
  type        = string
}

variable "private_subnets" {
  description = "List of private subnet IDs for RDS"
  type        = list(string)
}



variable "db_username" {
  description = "Database username"
  type        = string
  
}
variable "security_group_id" {
  description = "Security group ID for RDS"
  type        = string
}