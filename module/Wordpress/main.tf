resource "aws_instance" "wordpress" {

  ami           = var.ami_id
  instance_type = var.wordpress_instance_type
  key_name      = var.ec2_key_name
  subnet_id     = var.private_subnet_ids[0]
  security_groups = [var.bastion_sg_id]
}