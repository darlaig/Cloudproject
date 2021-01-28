
/* 
variable "vpc_id" {}
*/

/*
variable "public_subnet_id" {
 default = { 
   public1 = "subnet-0583695c9bdc1e742"
   public2 = "subnet-0afc85852eb771a57"
 }
}

*/


variable "vpc_cidr" {
  default = "10.0.0.0/24"
  type    = string
}


variable "availability_zone" {
  default = ["eu-west-1a", "eu-west-1b"]
  type    = list(string)
}


variable "public_subnets" {
  type = map
  default = {
    public1 = "10.0.0.0/28"
    public2 = "10.0.0.16/28"
  }
  description = "public subnet cidr blocks"
}

variable "public_network_int" {
  default     = ["10.0.0.11","10.0.0.12","10.0.0.29"]
  type        = list(string)
  description = "network interface attached to web server instances & bastion server"
}


variable "private_subnets" {
  default     = {
    private1 = "10.0.0.32/28"
    private2 = "10.0.0.48/28"
  }
  type        = map
  description = "private subnet cidr blocks"
}

variable "name" {
  default     = ["darl-vpc", "darl-igw"]
  type        = list(string)
  description = "vpc and internet gw tagged names"

}



