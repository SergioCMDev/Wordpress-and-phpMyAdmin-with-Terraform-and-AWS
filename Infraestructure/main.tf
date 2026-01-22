terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


provider "aws" {
  region = var.aws_region
}

module "Compute" {
  source            = "./modules/Compute"
  sg_base_ec2_id    = module.Security.sg_base_ec2_id
  sg_front_end_id   = module.Security.sg_front_end_id
  public_subnet1_id = module.Network.public_subnet_1_id
  db_user_data      = data.template_file.db_user_data.rendered
}

module "Security" {
  source = "./modules/02 - Security"

  customVPC_id   = module.Network.vpc_id
  public_ip      = var.public_ip
  aws_account_id = var.aws_account_id
}



module "Network" {
  source = "./modules/Network"

  aws_availability_zones = var.aws_availability_zones

}

module "DB" {
  source = "./modules/DB"

  db_subnet_group_name = module.Network.subnet_rds_group_name
  db_security_group_id = module.Security.sg_rds_id
  db_username          = var.db_username
  db_password          = var.db_password
  db_name              = var.db_name
}


data "template_file" "db_user_data" {
  template = file("${path.module}/user_data.sh.tpl")

  vars = {
    db_name     = module.DB.db_name
    db_user     = module.DB.db_username
    db_password = module.DB.db_password
    db_host     = module.DB.db_address
  }
}
