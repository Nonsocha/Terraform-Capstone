variable "ami_id" {
  type = string
}

variable "bastion_instance_type" {
  type = string
}

variable "ec2_key_name" {
  type = string
}

variable "public_subnet_id" {
  type = string
}
variable "security_group_ids" {
  description = "List of security group IDs to attach to the bastion instance"
  type        = list(string)
}