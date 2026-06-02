variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_pair_name" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "efs_id" {
  type = string
}

variable "access_point" {
  type = string
}

variable "rds_endpoint" {
  type = string

}

variable "db_user" {
  type = string
}

variable "db_password" {
  type = string
  
}

variable "db_name" {
  type = string
}

variable "target_group_arn" {
  type = string
  
}

variable "private_subnet_ids" {
  type = list(string)
  
}

variable "max_size" {
  type = number
  
}

variable "min_size" {
  type = number
}

variable "desired_capacity" {
  type = number
  
}