
variable "private_subnets" {
  description = "List of private subnet IDs for RDS"
  type        = list(string)
  
}

variable "security_group_id" {
  description = "Security group ID for RDS"
  type        = string
}