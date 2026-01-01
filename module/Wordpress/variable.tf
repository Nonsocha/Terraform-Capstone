variable "vpc_id" {
  description = "The ID of the VPC where resources are deployed."
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs."
  type        = list(string)
}

variable "ami_id" {
  description = "AMI ID to use for the EC2 instance."
}

variable "ec2_key_name" {
  description = "The EC2 key pair name to use for SSH access."
}

variable "wordpress_instance_type" {
  description = "Instance type for WordPress EC2 instance."
  default     = "t3.micro"
}

variable "bastion_sg_id" {
  description = "Security group ID of the Bastion host"
  type        = string
}