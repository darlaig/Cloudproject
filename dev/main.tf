
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

###### AWS Provider ###########

provider "aws" {

  region  = var.region
  profile = var.profile

}

/*
terraform {
  backend "s3" {
    bucket = "darl-tf-bucket"
    key    = "terraform.tfstate"
    region = "eu-west-1"
    dynamodb_table = "terraform-state"
  }
}
*/

module "devops_vpc" {
  source = "../modules/vpc"
}

module "dynamodb_table" {
  source = "../modules/dynamodb"

}

module "web_sg" {
  source             = "../modules/sg"
  myvpc              = module.devops_vpc.vpc_id
  public1_subnet_id  = module.devops_vpc.public1
  public2_subnet_id  = module.devops_vpc.public2
  private1_subnet_id = module.devops_vpc.private1
  private2_subnet_id = module.devops_vpc.private2

}

module "web_server" {
  source            = "../modules/web_ec2"
  instance_count    = 2
  #public_subnet_ids = [module.devops_vpc.public1, module.devops_vpc.public2]
  #security_groups   = [module.web_sg.web_security_group_id, module.web_sg.bastion_security_group_id]
  web_interface     = [module.web_sg.web1_interface, module.web_sg.web2_interface]

}


/*
    module "Jenkins_server" {
  source = "../modules/web_ec2"

  web_interface = module.web_sg.web1_interface
  Name = "darl-jenkins"
  web_interface2 = module.web_sg.web2_interface
}
*/



