
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider

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



module "devops_class_vpc" {
  source = "../modules/vpc"
 
}



module "web_sg" {
  source            = "../modules/sg"
  myvpc             = module.devops_class_vpc.vpc_id
  public_subnet_id  = module.devops_class_vpc.public
  private_subnet_id = module.devops_class_vpc.subid
  
}



  /*
  public1_subnet_id =
  private2_subnet_id =
  */







