resource "aws_instance" "bastion" {
    ami           = var.ami_id
    instance_type = var.instance_type
    key_name      = var.key_name
    subnet_id     = var.public_subnets[0]  # Using the first public subnet for the bastion host
    vpc_security_group_ids = [var.security_group_id]
  

  tags = {
    Name = "BastionHost"
  }
}