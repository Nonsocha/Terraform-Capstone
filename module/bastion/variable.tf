variable "ami_id" {
  description = "AMI ID for the bastion host"
  type        = string
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
}
variable "security_group_id" {
  description = "Security group ID for the bastion host"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet IDs for the bastion host"
  type        = list(string)
  
}

variable "vpc_id" {
  description = "VPC ID where the bastion host will be created"
  type        = string
  
}
variable "instance_type" {
  description = "Instance type for the bastion host"
  type        = string
  default     = "t3.micro"  # Default instance type, can be overridden
}

