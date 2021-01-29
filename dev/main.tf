
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
  source            = "../modules/sg"
  myvpc             = module.devops_vpc.vpc_id
  
}

/*
module "public_network_int" {
  source = "../modules/web_ec2"
  
}

*/






