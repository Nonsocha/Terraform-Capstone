variable "vpc_id" {
  type = string
}


  variable "allowed_ssh_cidr" {
  description = "CIDR blocks allowed to SSH into bastion host"
  type        = list(string)
  ##default     = ["0.0.0.0/0"]

}