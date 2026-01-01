variable "vpc_cidr" {
  type    = string
  default = "10.20.0.0/16"
}
variable "public_subnets" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.20.1.0/24", "10.20.2.0/24"]
}

variable "private_subnets" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.20.3.0/24", "10.20.4.0/24"]
  }