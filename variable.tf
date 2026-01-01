variable "vpc_cidr" {
  type    = string
}

variable "public_subnets" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}


variable "db_username" {
  description = "Database username"
  type        = string
  
}
variable "db_name" {
  description = "Datebase name"
  type        = string

}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
  
}

variable "vpc_id" {
  description = "VPC ID where the resources will be created"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the bastion host"
  type        = string
  
}

variable "key_pair_name" {
  description = "Key pair name for SSH access"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the bastion host"
  type        = string
  
}

