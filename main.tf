provider "aws" {
  region = "us-west-1"
}

module "vpc" {
  source = "./module/vpc"

  vpc_cidr        = var.vpc_cidr
    public_subnets  = var.public_subnets
    private_subnets = var.private_subnets

}

module "sg" {
  source = "./module/sg"

    vpc_id = module.vpc.vpc_id
}


module "alb" {
  source = "./module/alb"

  vpc_id            = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
  alb_sg_id         = module.sg.alb_sg_id


}

module "bastion" {
  source = "./module/bastion"

  vpc_id            = module.vpc.vpc_id
  security_group_id = module.sg.bastion_sg_id
  ami_id            = var.ami_id
  key_name          = var.key_pair_name
  public_subnets    = [element(module.vpc.public_subnets, 0)]  # Using the first public subnet for the bastion host

}

module "rds" {
  source = "./module/rds"

  db_name            = var.db_name
  db_username        = var.db_username
  db_password        = var.db_password
  private_subnets    = module.vpc.private_subnets
  security_group_id  = module.sg.rds_sg_id
}

module "asg" {
  source = "./module/asg"

  ami_id             = var.ami_id
  instance_type      = var.instance_type
  key_pair_name      = var.key_pair_name
  security_group_id  = [module.sg.webserver_sg_id]  # adjust if you have multiple SGs

  max_size           = 3
  min_size           = 1
  desired_capacity   = 1

  private_subnets  = module.vpc.private_subnets  # must be a list
  target_group_arn   = module.alb.target_group_arn

  efs_ap_id    = module.efs.efs_access_point_id
  efs_id       = module.efs.efs_id
  rds_endpoint = module.rds.rds_endpoint
  db_username  = module.rds.db_username
  db_password  = module.rds.db_password
  db_name      = module.rds.db_name

}

module "efs" {
  source = "./module/efs"

  private_subnets   = module.vpc.private_subnets
  security_group_id = module.sg.efs_sg_id
  
}