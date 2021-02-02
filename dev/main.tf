
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
  region  = "eu-west-1"
  profile = "darl"

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

module "web_sg" {
  source             = "../modules/sg"
  myvpc              = module.devops_vpc.vpc_id
  public_subnet_id   = module.devops_vpc.public
  public_subnet_mgt  = module.devops_vpc.bastion
  private1_subnet_id = module.devops_vpc.private1
  private2_subnet_id = module.devops_vpc.private2

}


module "web_server" {
  source           = "../modules/web_ec2"
  /*public_subnet_id = module.devops_vpc.public
  */
  web_interface = module.web_sg.web1_interface

}







