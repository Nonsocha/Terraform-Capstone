resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "Wordpress-db-subnet-group"
  }
  
}


resource "aws_db_instance" "wordpress" {

identifier              = "wordpress"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = var.db_instance_class
  allocated_storage       = var.allocated_storage
  db_name                 = var.db_name
  password                = var.db_password
  username                = var.db_user
  port                    = 3306

  vpc_security_group_ids = var.rds_security_group_ids
    db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name


    publicly_accessible    = false
    skip_final_snapshot    = true
    deletion_protection    = false
    multi_az               = false

    tags = {
    Name = "Wordpress-RDS"
    }

}