# ALB Security Group
resource "aws_security_group" "alb_sg" {
    name        = "alb-sg"
    description = "Security group for ALB"

    vpc_id = var.vpc_id
    
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    
    }

    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# SSH Security Group
resource "aws_security_group" "ssh_sg" {
    name        = "ssh-sg"
    description = "Security group for SSH access"

    vpc_id = var.vpc_id

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks =  ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
# Web Server Security Group
resource "aws_security_group" "webserver_sg" {
    name        = "webserver-sg"
    description = "Security group for web servers"

    vpc_id = var.vpc_id

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        security_groups = [aws_security_group.alb_sg.id]
    }

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        security_groups = [aws_security_group.ssh_sg.id]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# Database Security Group
resource "aws_security_group" "db_sg" {
    name        = "db-sg"
    description = "Security group for database"

    vpc_id = var.vpc_id

    ingress {
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        security_groups = [aws_security_group.webserver_sg.id]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# Bastion Security Group
resource "aws_security_group" "bastion_sg" {
    name        = "bastion-sg"
    description = "Security group for Bastion host"

    vpc_id = var.vpc_id

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# EFS Security Group
resource "aws_security_group" "efs_sg" {
    name        = "efs-sg"
    description = "Security group for EFS"

    vpc_id = var.vpc_id

    ingress {
        from_port   = 2049
        to_port     = 2049
        protocol    = "tcp"
        security_groups = [aws_security_group.webserver_sg.id, aws_security_group.db_sg.id]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
